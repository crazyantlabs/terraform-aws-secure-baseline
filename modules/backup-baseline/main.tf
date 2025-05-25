resource "aws_backup_report_plan" "this" {
  name        = replace(var.backup_report_plan_name, "-", "_")
  description = var.backup_report_plan_description

  report_delivery_channel {
    formats = [
      "CSV"
    ]
    s3_bucket_name = var.s3_bucket_name
    s3_key_prefix  = var.s3_key_prefix
  }

  report_setting {
    report_template = "RESTORE_JOB_REPORT"

    accounts = var.member_accounts
    regions  = var.regions
  }

  tags = var.tags
}