terraform {
  backend "s3" {
    bucket = "cicd-state-store"
    region = "eu-west-2"
    key    = "terraform.tfstate"
    acl    = "private"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    buildkite = {
      source  = "buildkite/buildkite"
      version = "~> 1.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

provider "buildkite" {
  organization = "gdimit07"
}

provider "github" {}