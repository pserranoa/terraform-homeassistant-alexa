# Alexa integration with home assistant AWS objects

This repository lets you to create the AWS objtects required to integrate
Alexa with [HomeAssistant](https://www.home-assistant.io/). 
More info [integration](https://www.home-assistant.io/integrations/alexa/)

based on: https://www.pacienciadigital.com/como-integrar-alexa-en-home-assistant/#Creacion_de_funcion_Lambda

## Required configuration

You should configure your backend. I recomend use app.terraform.io
You should create a terraform workspace.
You should configure your aws profile at ~/.aws/credentials

## Terraform created objects

- [x] IAM Role with rights to execute lambda.
- [x] Lambda with this [code](https://gist.github.com/matt2005/744b5ef548cc13d88d0569eea65f5e5b) inside.
- [x] Connection between Alexa and lambda.

## Example

```bash
bladerunner$ terraform plan -var-file=vars/$(cat .terraform/environment).tfvars
Acquiring state lock. This may take a few moments...

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_iam_role.lambda_alexa_homeassistant will be created
  + resource "aws_iam_role" "lambda_alexa_homeassistant" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "lambda.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "homeassistant_alexa_lambda-test_workspace"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags                  = {
          + "Name"    = "homeassistant_alexa_lambda-test_workspace"
          + "product" = "homeassistant"
          + "project" = "test_workspace"
        }
      + tags_all              = {
          + "Name"    = "homeassistant_alexa_lambda-test_workspace"
          + "product" = "homeassistant"
          + "project" = "test_workspace"
        }
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # aws_iam_role_policy_attachment.basic will be created
  + resource "aws_iam_role_policy_attachment" "basic" {
      + id         = (known after apply)
      + policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
      + role       = "homeassistant_alexa_lambda-test_workspace"
    }

  # aws_lambda_function.alexa_homeassistant will be created
  + resource "aws_lambda_function" "alexa_homeassistant" {
      + architectures                  = (known after apply)
      + arn                            = (known after apply)
      + description                    = "Connect Alexa with Homeassistant"
      + filename                       = "./.terraform/tmp/alexa_homeassistant.zip"
      + function_name                  = "lambda-alexa-homeassistant"
      + handler                        = "lambda_function.lambda_handler"
      + id                             = (known after apply)
      + invoke_arn                     = (known after apply)
      + last_modified                  = (known after apply)
      + memory_size                    = 128
      + package_type                   = "Zip"
      + publish                        = true
      + qualified_arn                  = (known after apply)
      + qualified_invoke_arn           = (known after apply)
      + reserved_concurrent_executions = -1
      + role                           = (known after apply)
      + runtime                        = "python3.9"
      + signing_job_arn                = (known after apply)
      + signing_profile_version_arn    = (known after apply)
      + source_code_hash               = (known after apply)
      + source_code_size               = (known after apply)
      + tags                           = {
          + "Name"    = "lambda_alexa_homeassistant-test_workspace"
          + "product" = "homeassistant"
        }
      + tags_all                       = {
          + "Name"    = "lambda_alexa_homeassistant-test_workspace"
          + "product" = "homeassistant"
        }
      + timeout                        = 300
      + version                        = (known after apply)

      + environment {
          + variables = {
              + "BASE_URL"                = (sensitive)
              + "DEBUG"                   = "true"
              + "LONG_LIVED_ACCESS_TOKEN" = (sensitive)
              + "NOT_VERIFY_SSL"          = "true"
            }
        }

      + ephemeral_storage {
          + size = (known after apply)
        }

      + tracing_config {
          + mode = (known after apply)
        }
    }

  # aws_lambda_permission.alexa_trigger will be created
  + resource "aws_lambda_permission" "alexa_trigger" {
      + action              = "lambda:InvokeFunction"
      + event_source_token  = (sensitive)
      + function_name       = "lambda-alexa-homeassistant"
      + id                  = (known after apply)
      + principal           = "alexa-connectedhome.amazon.com"
      + statement_id        = "AllowExecutionFromAlexa"
      + statement_id_prefix = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.
```
