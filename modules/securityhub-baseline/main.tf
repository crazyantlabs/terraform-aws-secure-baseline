data "aws_region" "current" {}

# --------------------------------------------------------------------------------------------------
# Enable SecurityHub
# --------------------------------------------------------------------------------------------------

locals {
  # https://docs.aws.amazon.com/securityhub/latest/userguide/controls-to-disable.html
  global_resources = [
    "Account.1",
    "Account.2",
    "IAM.1",
    "IAM.2",
    "IAM.3",
    "IAM.4",
    "IAM.5",
    "IAM.6",
    "IAM.7",
    "IAM.8",
    "IAM.9",
    "IAM.10",
    "IAM.11",
    "IAM.12",
    "IAM.13",
    "IAM.14",
    "IAM.15",
    "IAM.16",
    "IAM.17",
    "IAM.18",
    "IAM.19",
    "IAM.21",
    "IAM.22",
    "IAM.24",
    "IAM.25",
    "IAM.26",
    "IAM.27",
    "KMS.1",
    "KMS.2",
    "CloudFront.1",
    "CloudFront.3",
    "CloudFront.4",
    "CloudFront.7",
    "CloudFront.8",
    "CloudFront.10",
    "CloudFront.12",
    "CloudFront.13",
    "CloudFront.15",
    "CloudFront.16",
    "Route53.2",
    "WAF.1",
    "WAF.6",
    "WAF.7",
    "WAF.8",
  ]

  disabled_controls = [
    "Inspector.1",
    "Inspector.2",
    "Inspector.3",
    "GuardDuty.11",
    "GuardDuty.7",
    "EC2.10",
    "EC2.55",
    "EC2.56",
    "EC2.182",
    "EC2.58",
    "EC2.60",
    "Macie.1",
    "SSM.6",
    "S3.9",
    "CloudFront.5",
    "CloudFront.6",
    "CloudFront.9",
  ]
}

resource "aws_securityhub_account" "main" {
}

resource "aws_securityhub_finding_aggregator" "main" {
  count = var.aggregate_findings && var.master_account_id == "" ? 1 : 0

  linking_mode = "ALL_REGIONS"

  depends_on = [aws_securityhub_account.main]
}

# --------------------------------------------------------------------------------------------------
# Add member accounts
# --------------------------------------------------------------------------------------------------

resource "aws_securityhub_member" "members" {
  count = length(var.member_accounts)

  depends_on = [aws_securityhub_account.main]
  account_id = var.member_accounts[count.index].account_id
  email      = var.member_accounts[count.index].email
  invite     = true
}

resource "aws_securityhub_invite_accepter" "invitee" {
  count = var.master_account_id != "" ? 1 : 0

  master_id = var.master_account_id

  depends_on = [aws_securityhub_account.main]
}

# --------------------------------------------------------------------------------------------------
# Subscribe standards
# --------------------------------------------------------------------------------------------------

resource "aws_securityhub_standards_subscription" "cis" {
  count = var.enable_cis_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/cis-aws-foundations-benchmark/v/1.4.0"

  depends_on = [aws_securityhub_account.main]
}

# resource "aws_securityhub_standards_subscription" "cis-v3" {
#   count = var.enable_cis_standard ? 1 : 0

#   standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/cis-aws-foundations-benchmark/v/3.0.0"

#   depends_on = [aws_securityhub_account.main]
# }

resource "aws_securityhub_standards_subscription" "aws_foundational" {
  count = var.enable_aws_foundational_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/aws-foundational-security-best-practices/v/1.0.0"

  depends_on = [aws_securityhub_account.main]
}

resource "aws_securityhub_standards_subscription" "pci_dss" {
  count = var.enable_pci_dss_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/pci-dss/v/3.2.1"

  depends_on = [aws_securityhub_account.main]
}

# 3rd party products
resource "aws_securityhub_product_subscription" "products" {
  count = length(var.enable_product_arns)

  product_arn = replace(var.enable_product_arns[count.index], "<REGION>", data.aws_region.current.region)

  depends_on = [aws_securityhub_account.main]
}

# Disable global resources for regions other than us-east-1
data "aws_securityhub_standards_control_associations" "global_resources" {
  for_each = data.aws_region.current.region != "us-east-1" ? toset(local.global_resources) : toset([])
  
  security_control_id = each.key

  depends_on = [aws_securityhub_account.main]
}

locals {
  # Flatten control+standard pairs for global resources
  global_resources_to_disable = data.aws_region.current.region != "us-east-1" ? merge([
    for control_id, control_data in data.aws_securityhub_standards_control_associations.global_resources : {
      for assoc in coalesce(control_data.standards_control_associations, []) :
      "${control_id}/${assoc.standards_arn}" => {
        security_control_id = control_id
        standards_arn       = assoc.standards_arn
      }
    }
  ]...) : {}

  # Flatten control+standard pairs for disabled controls
  disabled_controls_to_disable = merge([
    for control_id, control_data in data.aws_securityhub_standards_control_associations.disabled_controls : {
      for assoc in coalesce(control_data.standards_control_associations, []) :
      "${control_id}/${assoc.standards_arn}" => {
        security_control_id = control_id
        standards_arn       = assoc.standards_arn
      }
    }
  ]...)
}

resource "aws_securityhub_standards_control_association" "disable_global_resources" {
  for_each = local.global_resources_to_disable

  standards_arn       = each.value.standards_arn
  security_control_id = each.value.security_control_id
  association_status  = "DISABLED"
  updated_reason      = "Global resources are not supported in this region"

  depends_on = [aws_securityhub_account.main]
}

# Disable controls that are not needed
data "aws_securityhub_standards_control_associations" "disabled_controls" {
  for_each = toset(local.disabled_controls)
    
  security_control_id = each.key

  depends_on = [aws_securityhub_account.main]
}

resource "aws_securityhub_standards_control_association" "disable_disabled_controls" {
  for_each = local.disabled_controls_to_disable
  
  standards_arn       = each.value.standards_arn
  security_control_id = each.value.security_control_id
  association_status  = "DISABLED"
  updated_reason      = "Not needed"

  depends_on = [aws_securityhub_account.main]
}