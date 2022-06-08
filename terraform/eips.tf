# Resource: aws_eip
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# Criação do eip address

# aloca public static ip address na aws

resource "aws_eip" "nat1" {
  depends_on = [aws_internet_gateway.main] # gateway da internet precisa estar presente na VPC (depende dele) 
}

resource "aws_eip" "nat2" {
  depends_on = [aws_internet_gateway.main] # gateway da internet precisa estar presente na VPC (depende dele) 
}