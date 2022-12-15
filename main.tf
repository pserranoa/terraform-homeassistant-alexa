terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.41.0"
    }
  }
  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "<organization>"

  #   workspaces {
  #     prefix = "aws_homeassistant_alexa_"
  #   }
  # }
  # backend "local" {
  #   path = "<relative/path/to/terraform.tfstate>"
  # }
}

provider "aws" {
  profile = "<profile>"
  region  = "<region>"
}