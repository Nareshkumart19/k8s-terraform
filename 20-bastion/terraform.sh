#!/bin/bash

# Exit on error
set -e

echo "🔧 Installing yum-utils..."
sudo yum install -y yum-utils
echo "✅ yum-utils installed."

echo "📦 Adding HashiCorp repo..."
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
echo "✅ HashiCorp repo added."

echo "🌍 Installing Terraform..."
sudo yum -y install terraform
echo "✅ Terraform installed."

echo "🧪 Verifying Terraform installation..."
terraform -version