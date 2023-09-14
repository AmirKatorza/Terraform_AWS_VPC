terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "amirk-develeap"

  default_tags {
    tags = {
      owner           = "amirk"
      bootcamp        = "19"
      expiration_date = "29-09-2024"
    }
  }
}
