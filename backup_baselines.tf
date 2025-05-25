locals {
  is_backup_enabled = var.backup_baseline_enabled && (local.is_individual_account || local.is_master_account)
  member_accounts = [for account in var.member_accounts : account.account_id]
}

# --------------------------------------------------------------------------------------------------
# Backup Baseline
# --------------------------------------------------------------------------------------------------

module "backup_baseline" {
  count  = local.is_backup_enabled ? 1 : 0
  source = "./modules/backup-baseline"

  backup_report_plan_name = var.backup_report_plan_name
  backup_report_plan_description = var.backup_report_plan_description

  member_accounts = concat([var.aws_account_id], local.member_accounts)
  regions = var.backup_regions

  s3_bucket_name                = local.audit_log_bucket_id
  s3_key_prefix                 = var.backup_s3_key_prefix
  
  tags = var.tags

  depends_on = [aws_s3_bucket_policy.audit_log]
}
