terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.83.0"
    }
  }
}

data "external" "github_token" {
  program = ["bash", "${path.module}/get_token.sh"]
}

provider "github" {
  token = data.external.github_token.result.token
  owner = var.github_owner
}

# AWS provider (for S3 bucket)
provider "aws" {
  region = "ap-south-1"
}

resource "github_repository" "new_repo" {
  name        = var.repo_name
  description = "Repository created using Terraform"
  visibility  = "public"
  auto_init   = true
}

