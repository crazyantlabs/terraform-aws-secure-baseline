variable "audit_s3_bucket_name" {
  description = "The name of the S3 bucket to store various audit logs."
  type        = string
}

variable "member_accounts" {
  description = "A list of AWS account IDs."
  type = list(object({
    account_id = string
    email      = string
  }))
}

variable "region" {
  description = "The AWS region in which global resources are set up."
  type        = string
  default     = "us-east-1"
}


