resource "aws_oam_sink" "monitoring" {
  count = var.monitoring_account_id == "" ? 1 : 0

  name = var.sink_name

  tags = var.tags
}

resource "aws_oam_sink_policy" "monitoring" {
  count = var.monitoring_account_id == "" ? 1 : 0

  sink_identifier = aws_oam_sink.monitoring[0].arn

  // See https://docs.aws.amazon.com/OAM/latest/APIReference/API_PutSinkPolicy.html for examples
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["oam:CreateLink", "oam:UpdateLink"]
        Effect   = "Allow"
        Resource = "*"
        Principal = {
          "AWS" = var.source_account_ids
        }
        Condition = {
          "ForAllValues:StringEquals" = {
            # Allow sending metrics and logs to the monitoring account
            "oam:ResourceTypes" = var.resource_types
          }
        }
      }
    ]
  })
}

# Account level link to the monitoring account
resource "aws_oam_link" "member" {
  # Only for source accounts
  count = var.monitoring_account_id != "" ? 1 : 0

  label_template  = var.label_template
  resource_types  = var.resource_types
  sink_identifier = var.sink_arn
  
  tags = var.tags
}
