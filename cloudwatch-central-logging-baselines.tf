
locals {
  cloudwatch_central_monitoring_monitoring_account_id = var.master_account_id
  cloudwatch_central_monitoring_source_account_ids   = [for account in var.member_accounts : account.account_id]

  is_monitoring_account = var.account_type == "master"
}

# --------------------------------------------------------------------------------------------------
# CloudWatch Central Logging Baseline
# --------------------------------------------------------------------------------------------------

module "cloudwatch_central_monitoring_baseline_ap-northeast-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "ap-northeast-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["ap-northeast-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_ap-northeast-2" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "ap-northeast-2") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["ap-northeast-2"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_ap-south-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "ap-south-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.ap-south-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["ap-south-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_ap-northeast-3" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "ap-northeast-3") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.ap-northeast-3
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["ap-northeast-3"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_ap-southeast-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "ap-southeast-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["ap-southeast-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_ap-southeast-2" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "ap-southeast-2") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["ap-southeast-2"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_ca-central-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "ca-central-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.ca-central-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["ca-central-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_eu-central-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "eu-central-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.eu-central-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["eu-central-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_eu-north-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "eu-north-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.eu-north-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["eu-north-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_eu-west-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "eu-west-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.eu-west-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["eu-west-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_eu-west-2" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "eu-west-2") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.eu-west-2
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["eu-west-2"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_eu-west-3" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "eu-west-3") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.eu-west-3
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["eu-west-3"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_sa-east-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "sa-east-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.sa-east-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["sa-east-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_us-east-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "us-east-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.us-east-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["us-east-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_us-east-2" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "us-east-2") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.us-east-2
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["us-east-2"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_us-west-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "us-west-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.us-west-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["us-west-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_us-west-2" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "us-west-2") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.us-west-2
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["us-west-2"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_il-central-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "il-central-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.il-central-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["il-central-1"], "")

  tags = var.tags
}

module "cloudwatch_central_monitoring_baseline_me-central-1" {
  count  = var.cloudwatch_central_monitoring_baseline_enabled && contains(var.target_regions, "me-central-1") ? 1 : 0
  source = "./modules/cloudwatch-central-monitoring-baseline"

  providers = {
    aws = aws.me-central-1
  }

  monitoring_account_id = local.cloudwatch_central_monitoring_monitoring_account_id
  source_account_ids    = local.cloudwatch_central_monitoring_source_account_ids
  resource_types        = var.cloudwatch_central_monitoring_resource_types
  sink_arn              = local.is_monitoring_account ? "" : try(var.cloudwatch_central_monitoring_sink_arn["me-central-1"], "")

  tags = var.tags
}
