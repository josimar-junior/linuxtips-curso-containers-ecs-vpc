resource "aws_iam_role" "api_gateway_logging" {
  name = format("%s-api-gtw-log", var.project_name)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "api_gateway_logging" {
  role       = aws_iam_role.api_gateway_logging.name
  policy_arn = data.aws_iam_policy.api_gateway_logging.arn
}

resource "aws_api_gateway_account" "api_gateway_logging" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_logging.arn
}