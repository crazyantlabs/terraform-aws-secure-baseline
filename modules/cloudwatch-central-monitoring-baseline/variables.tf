variable "monitoring_account_id" {
  description = "AWS account ID for monitoring account."
  type        = string
  default     = ""
}

variable "source_account_ids" {
  description = "The list of account IDs that will be allowed to send metrics to the monitoring account"
  type = list(string) 
  default = []
}

variable "resource_types" {
  description = "The list of resource types that will be allowed to send metrics to the monitoring account"
  type = list(string)
  default = ["AWS::CloudWatch::Metric", "AWS::Logs::LogGroup"]
}

variable "label_template" {
  description = "The label template to apply to the monitoring data sink"
  type = string
  default = "$AccountName"
}

variable "sink_name" {
  description = "The name of the monitoring data sink"
  type = string
  default = "monitoring-baseline-sink"
}

variable "sink_arn" {
  description = "The ARN of the monitoring data sink. Only used for source account level link."
  type = string
  default = ""
}

variable "tags" {
  description = "The tags to apply to the monitoring data sink"
  type = map(string)
}
