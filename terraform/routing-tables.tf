# Resource: aws_route_table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

# São criados 3 Route tables:
# - Um public route table com uma rota default para o gateway da internet
# - E mais duas private route tables para os dois NAT gateways diferentes


# Criação do route table publico
resource "aws_route_table" "public" {
  # O VPC ID 
  vpc_id = aws_vpc.main.id # Vem do arquivo vpc.tf

  route {
    # bloco CIDR do route 
    cidr_block = "0.0.0.0/0"

    # Intentificador de um internet gateway de um VPC
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-Mitu"
  }
}

# Primeiro Private routing table 
resource "aws_route_table" "private1" {
  # O VPC ID 
  vpc_id = aws_vpc.main.id # Vem do arquivo vpc.tf

  route {
    # bloco CIDR do route 
    cidr_block = "0.0.0.0/0"

    # Identificador de um VPC NAT Gateway
    nat_gateway_id = aws_nat_gateway.gw1.id
  }

  tags = {
    Name = "private1-Mitu"
  }
}

# Segundo Private routing table 
resource "aws_route_table" "private2" {
  # O VPC ID 
  vpc_id = aws_vpc.main.id # Vem do arquivo vpc.tf

  route {
    # bloco CIDR do route 
    cidr_block = "0.0.0.0/0"

    # Identificador de um VPC NAT Gateway
    nat_gateway_id = aws_nat_gateway.gw2.id
  }

  tags = {
    Name = "private2-Mitu"
  }
}