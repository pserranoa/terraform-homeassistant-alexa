data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_alexa_homeassistant" {
  name               = "homeassistant_alexa_lambda-${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
  tags = {
    Name    = "homeassistant_alexa_lambda-${terraform.workspace}"
    project = "${terraform.workspace}"
    product = "homeassistant"
  }
}

resource "aws_iam_role_policy_attachment" "basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_alexa_homeassistant.name
}