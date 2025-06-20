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
### Run terraform to create repo 
```
terraform plan -var='github_owner=DhruvShah0612' -var='repo_name=Terraform-Git'
terraform apply -auto-approve -var='github_owner=DhruvShah0612' -var='repo_name=Terraform-Git'
```
✅ Result
### The Terraform-created GitHub repo will be:
```
📎 https://github.com/DhruvShah0612/Terraform-Git
```

### Task :-3: Create a .gitignore File for Terraform
```
nano .gitignore
```
```
# Ignore Terraform state files
*.tfstate
*.tfstate.backup

# Ignore Terraform crash logs
crash.log

# Ignore .terraform directory
.terraform/

# Ignore any sensitive file scripts
*.pem
get_token.sh

# Ignore plan output
*.tfplan

# Ignore local IDE/editor settings
.vscode/
.idea/
*.swp
.DS_Store
```
### Task 2:- Push Terraform Project to GitHub 
```
nano push_code.sh
```
```
#!/bin/bash

set -e

GITHUB_USER="DhruvShah0612"
REPO_NAME="Terraform-Git"
REPO_URL="https://github.com/$GITHUB_USER/$REPO_NAME.git"

echo "🔧 Initializing Git repo..."
git init

echo "🔗 Adding remote..."
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

echo "📥 Pulling remote to prevent conflict..."
git pull origin main --allow-unrelated-histories || true

echo "📦 Adding & committing files..."
git add .
git commit -m "🔧 Setup Terraform repo with .gitignore and main configuration" || echo "✅ Nothing new to commit."

echo "🚀 Pushing to GitHub..."
git branch -M main
git push -u origin main

echo "✅ Successfully pushed to $REPO_URL"
```
```
chmod +x push_code.sh
```
```
./push_code.sh
```







