terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
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

resource "github_repository" "new_repo" {
  name        = var.repo_name
  description = "Repository created using Terraform"
  visibility  = "public"
  auto_init   = true
}
