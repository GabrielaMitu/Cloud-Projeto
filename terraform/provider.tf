provider "aws" {
  profile = "terraform" # nome do profile da aws (no cmd faz: aws configure --profile terraform)
  region  = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12" # aceita versão maior do que 3.21
    }
  }
}

# Obs.: vou armazenar localmente, então não usa aqui o s3 bucket ou qualquer um outro storage
