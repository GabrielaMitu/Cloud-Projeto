# Resource aws_internet_gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

resource "aws_internet_gateway" "main" {
  # VPC ID para criar
  vpc_id = aws_vpc.main.id # baseado no file vpc.tf

  # Mapa de tags para atribuir para um recurso (opcional)
  tags = {
    Name = "mainMitu"
  }
}

# Obs.: Para pegar o vpc_id, dá para fazer tbm um copy paste do site:
# https://us-east-1.console.aws.amazon.com/vpc/home?region=us-east-1#vpcs:
