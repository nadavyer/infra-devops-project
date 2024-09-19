#!/bin/bash
set -euo pipefail

# Find all .tf files in the current directory and all subdirectories and format them
find . -type f -name "*.tf" -exec terraform fmt {} \;

echo "All Terraform files have been formatted."