terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = ">= 3.4.0"
    }

  }
}

provider "aws" {
  region = "us-east-1"
}

provider "tls" {

}