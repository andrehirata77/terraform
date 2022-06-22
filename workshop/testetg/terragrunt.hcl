generate "remote_state" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "remote" {
    hostname = "app.terraform.io" # Change this to your hostname for TFE
    organization = "ccoe-ttech"
    workspaces {
      name = "terragrunt"
    }
  }
}
EOF
}

inputs = {
    location = "brazilsouth"
    rg = "rg-terragrunt"
}