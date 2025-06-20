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
