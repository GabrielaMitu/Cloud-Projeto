# Resource: aws_vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

# Definição do VPC no terraform
# recurso address VPC que vai permitir criar os VPS no aws

resource "aws_vpc" "main" {
  # bloco CIDR para o VPC
  cidr_block = "192.168.0.0/16"

  # faz as instâncias serem comparilhadas no host
  instance_tenancy = "default"

  # Necessário para o EKS. Habilitar/Desabilitar suporte DNS no VPC
  enable_dns_support = true

  # Necessário para o EKS. Habilitar/Desabilitar hostnames do DNS no VPC
  enable_dns_hostnames = true

  # Habilitar/Desabilitar ClassicLink para o VPC
  enable_classiclink = false

  # Habilitar/Desabilitar suporte ClassicLink DNS para o VPC
  enable_classiclink_dns_support = false

  # Requisita um bloco IPv6 CIDR da Amazon (não precisa de um IPv6)
  assign_generated_ipv6_cidr_block = false

  # Mapa de tags para atribuir para um recurso
  tags = {
    Name = "mainMitu"
  }
}

# Opcional
# valor -> Que tipo de valor eu quero colocar. Pode ser útil se eu quiser usar esses outputs em módulos. 
# Basicamente aproveitar p usar módulos usando valores de outros módulos 
output "vpc_id" {
  value       = aws_vpc.main.id # Valores definidos da linha 7 no caso. Esse .id dá para ver na documentação que podemos pegar o id dessa forma
  description = "VPC id."
  sensitive   = false # evita Terraform de mostrar seus valores no plan e no apply
}

