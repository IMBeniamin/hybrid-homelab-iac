terraform {
  required_version = ">= 1.10"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 9.0"
    }
  }
}

variable "tenancy_ocid" {
  type    = string
  default = "ocid1.tenancy.oc1..aaaaaaaaexample00000000000000000000000000000000000000000000"
}

variable "compartment_ocid" {
  type    = string
  default = "ocid1.compartment.oc1..aaaaaaaaexample000000000000000000000000000000000000000000"
}

variable "region" {
  type    = string
  default = "eu-frankfurt-1"
}

provider "oci" {
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = "ocid1.user.oc1..aaaaaaaaexample0000000000000000000000000000000000000000000000"
  fingerprint      = "00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff"
  private_key_path = ""
}
