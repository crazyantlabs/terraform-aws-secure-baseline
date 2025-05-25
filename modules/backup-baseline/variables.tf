variable "backup_report_plan_name" {
  description = "The name of the backup report plan."
  type        = string
  default     = "backup-report-plan"
}

variable "backup_report_plan_description" {
  description = "The description of the backup report plan."
  type        = string
  default     = "Backup report plan"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket which will store backup reports."
  type        = string
}

variable "s3_key_prefix" {
  description = "The prefix for the specified S3 bucket."
  type        = string
  default     = ""
}

variable "member_accounts" {
  description = "The list of member accounts to enable backup report plan."
  type        = list(string)
}

variable "regions" {
  description = "The list of regions to enable backup report plan."
  type        = list(string)
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default = {
    "Terraform" = "true"
  }
}
