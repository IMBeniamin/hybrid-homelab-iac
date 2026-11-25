terraform {
  required_version = ">= 1.10"
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "~> 1.99"
    }
  }
}

variable "router_password" {
  type      = string
  sensitive = true
}

provider "routeros" {
  hosturl  = "apis://192.168.50.1:8729"
  username = "iac-automation"
  password = var.router_password
}

resource "routeros_system_scheduler" "nightly_wake" {
  name       = "homelab-nightly-wake"
  start_time = "01:15:00"
  interval   = "1d"
  on_event   = "/tool wol interface=bridge1 mac=02:00:00:00:00:10"
  disabled   = true
  comment    = "Optional nightly maintenance wake window"
}
