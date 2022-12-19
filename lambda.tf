data "archive_file" "alexa_homeassistant" {
  type        = "zip"
  source_dir  = "${path.root}/package/alexa_homeassistant/"
  output_path = "${path.root}/.terraform/tmp/alexa_homeassistant.zip"
}

resource "aws_lambda_function" "alexa_homeassistant" {
  filename      = "${path.root}/.terraform/tmp/alexa_homeassistant.zip"
  function_name = "lambda-alexa-homeassistant"
  role          = aws_iam_role.lambda_alexa_homeassistant.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 300
  memory_size   = 128
  description   = "Connect Alexa with Homeassistant"
  publish       = true

  tags = {
    Name    = "lambda_alexa_homeassistant-${terraform.workspace}"
    product = "homeassistant"
  }

  environment {
    variables = {
      BASE_URL                = var.base_url
      LONG_LIVED_ACCESS_TOKEN = var.long_lived_access_token
      NOT_VERIFY_SSL          = var.verify_ssl
      DEBUG                   = var.debug
    }
  }

  depends_on = [data.archive_file.alexa_homeassistant]
}

resource "aws_lambda_permission" "alexa_trigger" {
  statement_id     = "AllowExecutionFromAlexa"
  action      = "lambda:InvokeFunction"
  function_name = aws_lambda_function.alexa_homeassistant.function_name
  principal     = "alexa-appkit.amazon.com"
  event_source_token = var.alexa_skill
}