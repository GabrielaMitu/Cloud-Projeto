# Resource aws_nat_gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway

# ------ Primeiro nat_gateway -----
resource "aws_nat_gateway" "gw1" {
  # Allocation ID do Elastic ID address para o gateway
  allocation_id = aws_eip.nat1.id # aws_eip -> referencia para o exato elastic IP address

  # The Subnet ID of the subnet in which to place the gateway
  subnet_id = aws_subnet.public_1.id # precisa ser um das subnets publicas. Está referenciado do file subnets.tf

  # Map of tags
  tags = {
    Name = "NAT 1 - Mitu"
  }
}

# ------ Segundo nat_gateway -----

resource "aws_nat_gateway" "gw2" {
  # Allocation ID do Elastic ID address para o gateway
  allocation_id = aws_eip.nat2.id # aws_eip -> referencia para o exato elastic IP address

  # The Subnet ID of the subnet in which to place the gateway
  subnet_id = aws_subnet.public_2.id # precisa ser um das subnets publicas. Está referenciado do file subnets.tf

  # Map of tags
  tags = {
    Name = "NAT 2 - Mitu"
  }
}

#Obs.: nat_gateway funciona de uma forma que traduz o endereço IP private para acessar a internet. 
# Então o nat_gateway precisa ter o public ip address
# Cada um dosNAT Gateways estão em diferentes availability_zone. Logo, se algo acontecer com um,
# Ainda há o segundo (redundant) NAT_Gateway

# ------- VERIFICAÇÃO -------

# Para verificar os Elastic IP addresses: https://us-east-1.console.aws.amazon.com/vpc/home?region=us-east-1#Addresses:

# Pra verificar os NAT Gateways: https://us-east-1.console.aws.amazon.com/vpc/home?region=us-east-1#NatGateways:
