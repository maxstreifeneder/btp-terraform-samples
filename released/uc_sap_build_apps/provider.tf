
terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "0.3.0-beta1"
    }
  }
}

provider "btp" {
  globalaccount  = var.globalaccount
  cli_server_url = var.cli_server_url
}
