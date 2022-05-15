# HCL - Haschicorp Configuration Language
# Linguagem Declarativa

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.4.0"
    }
  }
}

resource "aws_s3_bucket" "dl" {
  #Parametros de Configuração do Recurso Escolhido
  bucket = "datalake-ney-igti-edc-tf"
  acl    = "private"
 
  tags = {
    AVA = "EDC"
    IES = "ALEX"
  }

 #Configuração de Criptografia em Rest
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}