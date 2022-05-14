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

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "datalake" {
  #Parametros de Configuração do Recurso Escolhido
  bucket = "${var.base_bucket_name}-${var.ambiente}-${var.numero_conta}"
  acl    = "private"
  #Configuração de Criptografia em Rest
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    AVA = "EDC"
    IES = "ALEX"
  }
}
resource "aws_s3_bucket_object" "codigo_spark" {
  bucket = aws_s3_bucket.datalake.id
  key    = "emr-code/pyspark/job_spark_from_tf.py"
  acl    = "private"
  source = "job_spark.py"
  etag   = filemd5("job_spark.py")
}


