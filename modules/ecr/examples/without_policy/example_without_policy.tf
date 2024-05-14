terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.49.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Terraform = true
    }
  }
}

locals {
  tags = {
    Environment  = "Prod"
    Terraform    = true
    Application  = "TDA Trading App"
  }
}


module "stock_scanner" {
  source               = "../../"
  name                 = "stock_scanner"
  encryption_type      = "KMS"
  image_tag_mutability = "MUTABLE"
  tags = local.tags
}

module "stock-data-download" {
  source               = "../../"
  name                 = "stock-data-download"
  encryption_type      = "KMS"
  image_tag_mutability = "IMMUTABLE"
  tags = local.tags
}

module "pattern1" {
  source               = "../../"
  name                 = "pattern1"
  encryption_type      = "KMS"
  image_tag_mutability = "MUTABLE"
  tags = local.tags
}

