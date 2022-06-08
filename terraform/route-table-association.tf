# Resource aws_route_table_association
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

# Há aqui 4 subnets no total, então são feitas 4 associações 

# --- ASSOCIAÇÃO DOS NAT GATEWAY PUBLICOS COM ROUTE TABLE PUBLICA------
resource "aws_route_table_association" "public1" {
  # Subnet ID para criar a aassociação
  subnet_id = aws_subnet.public_1.id # vem do file subnets.ft

  # O ID do routing table para ser associado com
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  # Subnet ID para criar a aassociação
  subnet_id = aws_subnet.public_2.id # vem do file subnets.ft

  # O ID do routing table para ser associado com
  route_table_id = aws_route_table.public.id
}

# Obs.: usam o mesmo public route table

# --- ASSOCIAÇÃO DAS SUBNETS PRIVADAS COM OS ROUTER TABLES ------

resource "aws_route_table_association" "private1" {
  # Subnet ID para criar a aassociação
  subnet_id = aws_subnet.private_1.id # vem do file subnets.ft

  # O ID do routing table para ser associado com
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "private2" {
  # Subnet ID para criar a aassociação
  subnet_id = aws_subnet.private_2.id # vem do file subnets.ft

  # O ID do routing table para ser associado com
  route_table_id = aws_route_table.private2.id
}