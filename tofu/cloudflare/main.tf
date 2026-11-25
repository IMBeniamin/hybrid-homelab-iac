terraform {
  required_version = ">= 1.10"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket                      = "example-tofu-state"
    key                         = "cloudflare/terraform.tfstate"
    region                      = "auto"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true
  }
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "zone_id" {
  type    = string
  default = "00000000000000000000000000000000"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_dns_record" "auth" {
  zone_id = var.zone_id
  name    = "auth.example.com"
  type    = "A"
  content = "198.51.100.10"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "status" {
  zone_id = var.zone_id
  name    = "status.example.com"
  type    = "CNAME"
  content = "edge.example.com"
  proxied = true
  ttl     = 1
}
