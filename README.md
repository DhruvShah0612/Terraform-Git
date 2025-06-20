# Terraform-Git
## Repository created using Terraform

🔐 Step 1: Store GitHub Token Using aws configure
Go to :- cmd
```
aws configure --profile github
```
Provide:
```
AWS Access Key ID     : ghp_your_github_token_here
AWS Secret Access Key : dummy
Region                : none
Output format         : none
```

### Task:-1 Initialize a Git Repository for Terraform Code
```
nano main.tf
```
```
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
```
```
nano varible.tf
```
```
variable "github_owner" {
  type = string
}

variable "repo_name" {
  type = string
}
```
```
nano get_token.sh
```
```
#!/bin/bash

token=$(aws configure get aws_access_key_id --profile github)

if [ -z "$token" ]; then
  echo "Token not found in AWS profile 'github'" >&2
  exit 1
fi

echo "{\"token\": \"$token\"}"
```
```
chmod +x get_token.sh
```
```
nano init_repo.sh
```
```
#!/bin/bash
set -e

echo "🛠️ Initializing Terraform..."
terraform init

echo "📊 Planning infrastructure..."
terraform plan -var='github_owner=DhruvShah0612' -var='repo_name=Terraform-Git'

echo "🚀 Applying Terraform..."
terraform apply -auto-approve -var='github_owner=DhruvShah0612' -var='repo_name=Terraform-Git'
```
```
chmod +x init_repo.sh
```

```
terraform plan -var='github_owner=DhruvShah0612' -var='repo_name=Terraform-Git'
terraform apply -auto-approve -var='github_owner=DhruvShah0612' -var='repo_name=Terraform-Git'
```
✅ Result
## The Terraform-created GitHub repo will be:
```
📎 https://github.com/DhruvShah0612/Terraform-Git
```




