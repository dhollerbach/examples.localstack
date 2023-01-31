# Uses for each to create them all
# https://binx.io/2020/06/17/create-multiple-resources-at-once-with-terraform-for_each/
# https://learn.hashicorp.com/tutorials/terraform/for-each
data "archive_file" "primary" {
  type = "zip"

  source_dir  = var.source_dir != "" ? var.source_dir : "${path.module}/python"
  output_path = var.output_path != "" ? var.output_path : "${path.module}/python.zip"
}

resource "aws_iam_role" "primary" {
  name = var.lambda_role_name != "" ? var.lambda_role_name : "${var.name}_lambda_role"
  #this inline policy is needed to set up the Trust relationships properly (as seen in the AWS console)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_lambda_function" "primary" {
  function_name = var.name
  role          = aws_iam_role.primary.arn
  handler       = var.handler

  filename         = data.archive_file.primary.output_path
  source_code_hash = data.archive_file.primary.output_base64sha256

  runtime       = var.runtime
  architectures = var.architectures

  environment {
    variables = var.environment_variables
  }

  timeout = var.timeout

  # layers = [for ll in aws_lambda_layer_version.lambda_layer : ll.arn]

  publish = var.publish

  depends_on = [
    aws_cloudwatch_log_group.primary,
    aws_iam_role_policy_attachment.primary
  ]
}

resource "aws_cloudwatch_log_group" "primary" {
  name              = var.cloudwatch_log_group_name != "" ? var.cloudwatch_log_group_name : "/aws/lambda/${var.name}"
  retention_in_days = var.cloudwatch_log_group_retention
}

resource "aws_iam_policy" "primary" {
  name        = var.iam_policy_name != "" ? var.iam_policy_name : "${var.name}_lambda_logging"
  description = "Provides logging capabilities to the lambda"
  path        = "/" #usually not changed
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "${aws_cloudwatch_log_group.primary.arn}:*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "primary" {
  role       = aws_iam_role.primary.name
  policy_arn = aws_iam_policy.primary.arn
}

# resource "aws_lambda_alias" "primary" {
#   name             = var.alias
#   function_name    = aws_lambda_function.primary.name
#   function_version = each.value.alias_version > 0 ? each.value.alias_version : sum([tonumber(aws_lambda_function.lambda[each.key].version), each.value.alias_version])
# }

# resource "aws_ssm_parameter" "lambda_live_invoke_arn" {
#   for_each = local.lambda_info
#   name     = "lambda_${each.value.name}_live_invoke_arn"
#   type     = "String"
#   value    = aws_lambda_alias.lambda_alias[each.key].invoke_arn
# }