locals {
  config_topics = [
    one(module.config_baseline_ap-northeast-1[*].config_sns_topic),
    one(module.config_baseline_ap-northeast-2[*].config_sns_topic),
    one(module.config_baseline_ap-northeast-3[*].config_sns_topic),
    one(module.config_baseline_ap-south-1[*].config_sns_topic),
    one(module.config_baseline_ap-southeast-1[*].config_sns_topic),
    one(module.config_baseline_ap-southeast-2[*].config_sns_topic),
    one(module.config_baseline_ca-central-1[*].config_sns_topic),
    one(module.config_baseline_eu-central-1[*].config_sns_topic),
    one(module.config_baseline_eu-north-1[*].config_sns_topic),
    one(module.config_baseline_eu-west-1[*].config_sns_topic),
    one(module.config_baseline_eu-west-2[*].config_sns_topic),
    one(module.config_baseline_eu-west-3[*].config_sns_topic),
    one(module.config_baseline_sa-east-1[*].config_sns_topic),
    one(module.config_baseline_us-east-1[*].config_sns_topic),
    one(module.config_baseline_us-east-2[*].config_sns_topic),
    one(module.config_baseline_us-west-1[*].config_sns_topic),
    one(module.config_baseline_us-west-2[*].config_sns_topic),
    one(module.config_baseline_il-central-1[*].config_sns_topic),
    one(module.config_baseline_me-central-1[*].config_sns_topic),
  ]
}

# --------------------------------------------------------------------------------------------------
# Create an IAM Role for AWS Config recorder to publish results and send notifications.
# Reference: https://docs.aws.amazon.com/config/latest/developerguide/gs-cli-prereq.html#gs-cli-create-iamrole
# --------------------------------------------------------------------------------------------------

data "aws_iam_policy_document" "recorder_assume_role_policy" {
  count = var.config_baseline_enabled ? 1 : 0

  statement {
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# Use service-linked role for AWS Config recorder
resource "aws_iam_service_linked_role" "recorder" {
  aws_service_name = "config.amazonaws.com"
}

# --------------------------------------------------------------------------------------------------
# AWS Config Baseline
# Needs to be set up in each region.
# Global resource types are only recorded in the region specified by var.region.
# --------------------------------------------------------------------------------------------------

module "config_baseline_ap-northeast-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "ap-northeast-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "ap-northeast-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_ap-northeast-2" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "ap-northeast-2") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "ap-northeast-2"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_ap-northeast-3" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "ap-northeast-3") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.ap-northeast-3
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "ap-northeast-3"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_ap-south-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "ap-south-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.ap-south-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "ap-south-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_ap-southeast-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "ap-southeast-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "ap-southeast-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_ap-southeast-2" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "ap-southeast-2") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "ap-southeast-2"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_ca-central-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "ca-central-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.ca-central-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "ca-central-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_eu-central-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "eu-central-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.eu-central-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "eu-central-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_eu-north-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "eu-north-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.eu-north-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "eu-north-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_eu-west-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "eu-west-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.eu-west-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "eu-west-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_eu-west-2" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "eu-west-2") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.eu-west-2
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "eu-west-2"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types


  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_eu-west-3" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "eu-west-3") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.eu-west-3
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "eu-west-3"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types
  
  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_sa-east-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "sa-east-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.sa-east-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "sa-east-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_us-east-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "us-east-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.us-east-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "us-east-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_us-east-2" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "us-east-2") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.us-east-2
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "us-east-2"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_us-west-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "us-west-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.us-west-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "us-west-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_us-west-2" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "us-west-2") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.us-west-2
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "us-west-2"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_il-central-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "il-central-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.il-central-1
  }

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "il-central-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

module "config_baseline_me-central-1" {
  count  = var.config_baseline_enabled && contains(var.target_regions, "me-central-1") ? 1 : 0
  source = "./modules/config-baseline"

  providers = {
    aws = aws.me-central-1
  } 

  iam_role_arn                  = aws_iam_service_linked_role.recorder.arn
  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.config_s3_bucket_key_prefix
  delivery_frequency            = var.config_delivery_frequency
  sns_topic_name                = var.config_sns_topic_name
  sns_topic_kms_master_key_id   = var.config_sns_topic_kms_master_key_id
  include_global_resource_types = var.config_global_resources_all_regions ? true : var.region == "me-central-1"
  exclusion_by_resource_types   = var.config_exclusion_by_resource_types

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}

# --------------------------------------------------------------------------------------------------
# Global Config Rules
# --------------------------------------------------------------------------------------------------

resource "aws_config_config_rule" "iam_mfa" {
  count = var.config_baseline_enabled ? 1 : 0

  name = "IAMAccountMFAEnabled"

  source {
    owner             = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }

  tags = var.tags

  # Ensure this rule is created after all configuration recorders.
  depends_on = [
    module.config_baseline_ap-northeast-1,
    module.config_baseline_ap-northeast-2,
    module.config_baseline_ap-northeast-3,
    module.config_baseline_ap-south-1,
    module.config_baseline_ap-southeast-1,
    module.config_baseline_ap-southeast-2,
    module.config_baseline_ca-central-1,
    module.config_baseline_eu-central-1,
    module.config_baseline_eu-north-1,
    module.config_baseline_eu-west-1,
    module.config_baseline_eu-west-2,
    module.config_baseline_eu-west-3,
    module.config_baseline_sa-east-1,
    module.config_baseline_us-east-1,
    module.config_baseline_us-east-2,
    module.config_baseline_us-west-1,
    module.config_baseline_us-west-2,
    module.config_baseline_il-central-1,
    module.config_baseline_me-central-1,
  ]
}

resource "aws_config_config_rule" "unused_credentials" {
  count = var.config_baseline_enabled ? 1 : 0

  name             = "UnusedCredentialsNotExist"
  input_parameters = "{\"maxCredentialUsageAge\": \"90\"}"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_UNUSED_CREDENTIALS_CHECK"
  }

  tags = var.tags

  # Ensure this rule is created after all configuration recorders.
  depends_on = [
    module.config_baseline_ap-northeast-1,
    module.config_baseline_ap-northeast-2,
    module.config_baseline_ap-northeast-3,
    module.config_baseline_ap-south-1,
    module.config_baseline_ap-southeast-1,
    module.config_baseline_ap-southeast-2,
    module.config_baseline_ca-central-1,
    module.config_baseline_eu-central-1,
    module.config_baseline_eu-north-1,
    module.config_baseline_eu-west-1,
    module.config_baseline_eu-west-2,
    module.config_baseline_eu-west-3,
    module.config_baseline_sa-east-1,
    module.config_baseline_us-east-1,
    module.config_baseline_us-east-2,
    module.config_baseline_us-west-1,
    module.config_baseline_us-west-2,
    module.config_baseline_il-central-1,
    module.config_baseline_me-central-1,
  ]
}

resource "aws_config_config_rule" "user_no_policies" {
  count = var.config_baseline_enabled ? 1 : 0

  name = "NoPoliciesAttachedToUser"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }

  scope {
    compliance_resource_types = [
      "AWS::IAM::User",
    ]
  }

  tags = var.tags

  # Ensure this rule is created after all configuration recorders.
  depends_on = [
    module.config_baseline_ap-northeast-1,
    module.config_baseline_ap-northeast-2,
    module.config_baseline_ap-northeast-3,
    module.config_baseline_ap-south-1,
    module.config_baseline_ap-southeast-1,
    module.config_baseline_ap-southeast-2,
    module.config_baseline_ca-central-1,
    module.config_baseline_eu-central-1,
    module.config_baseline_eu-north-1,
    module.config_baseline_eu-west-1,
    module.config_baseline_eu-west-2,
    module.config_baseline_eu-west-3,
    module.config_baseline_sa-east-1,
    module.config_baseline_us-east-1,
    module.config_baseline_us-east-2,
    module.config_baseline_us-west-1,
    module.config_baseline_us-west-2,
    module.config_baseline_il-central-1,
    module.config_baseline_me-central-1,
  ]
}

resource "aws_config_config_rule" "no_policies_with_full_admin_access" {
  count = var.config_baseline_enabled ? 1 : 0

  name = "NoPoliciesWithFullAdminAccess"

  source {
    owner             = "AWS"
    source_identifier = "IAM_POLICY_NO_STATEMENTS_WITH_ADMIN_ACCESS"
  }

  scope {
    compliance_resource_types = [
      "AWS::IAM::Policy",
    ]
  }

  tags = var.tags

  # Ensure this rule is created after all configuration recorders.
  depends_on = [
    module.config_baseline_ap-northeast-1,
    module.config_baseline_ap-northeast-2,
    module.config_baseline_ap-northeast-3,
    module.config_baseline_ap-south-1,
    module.config_baseline_ap-southeast-1,
    module.config_baseline_ap-southeast-2,
    module.config_baseline_ca-central-1,
    module.config_baseline_eu-central-1,
    module.config_baseline_eu-north-1,
    module.config_baseline_eu-west-1,
    module.config_baseline_eu-west-2,
    module.config_baseline_eu-west-3,
    module.config_baseline_sa-east-1,
    module.config_baseline_us-east-1,
    module.config_baseline_us-east-2,
    module.config_baseline_us-west-1,
    module.config_baseline_us-west-2,
    module.config_baseline_il-central-1,
    module.config_baseline_me-central-1,
  ]
}

# --------------------------------------------------------------------------------------------------
# Aggregator View
# Only created for the master account.
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "config_organization_assume_role_policy" {
  count = var.config_baseline_enabled ? 1 : 0

  statement {
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "config_organization" {
  count = var.config_baseline_enabled && local.is_master_account ? 1 : 0

  name_prefix        = var.config_aggregator_name_prefix
  assume_role_policy = data.aws_iam_policy_document.config_organization_assume_role_policy[0].json

  permissions_boundary = var.permissions_boundary_arn

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "config_organization" {
  count = var.config_baseline_enabled && local.is_master_account ? 1 : 0

  role       = aws_iam_role.config_organization[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

resource "aws_config_configuration_aggregator" "organization" {
  count = var.config_baseline_enabled && local.is_master_account ? 1 : 0

  name = var.config_aggregator_name

  organization_aggregation_source {
    all_regions = true
    role_arn    = aws_iam_role.config_organization[0].arn
  }

  tags = var.tags
}

