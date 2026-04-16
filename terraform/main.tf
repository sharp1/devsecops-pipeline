terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "trusted_ssh_cidr" {
  description = "Trusted CIDR allowed to access SSH"
  type        = string
  default     = "10.0.0.0/24"
}

resource "aws_security_group" "restricted_sg" {
  name        = "restricted-sg"
  description = "Restricted SSH access for pipeline testing"

  ingress {
    description = "SSH restricted to trusted CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.trusted_ssh_cidr]
  }
}
