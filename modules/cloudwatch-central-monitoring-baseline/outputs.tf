output "sink_arn" {
  description = "The ARN of the created monitoring sink (only populated when creating a sink in monitoring account)"
  value       = var.monitoring_account_id == "" ? aws_oam_sink.monitoring[0].arn : null
}
