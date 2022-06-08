# Resource aws_subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet


# Criação de 4 subnets

resource "aws_subnet" "public_1" {
  # VPC ID
  vpc_id = aws_vpc.main.id

  # bloco CIDR para a subnet
  cidr_block = "192.168.0.0/18" # vai até o 63, por isso o public_2 começa em 64

  # AZ para a subnet
  availability_zone = "us-east-1a"

  # Requisitado pelo EKS. Toda nova instância que vai ser deployed na subnet pública
  # vai automaticamenete pegar o endereço do IP publico. Se eu quiser deploy do worker não na
  # subnet privada, mas sim na pública, todas as instâncias precisam ter os endereços  do IP publico
  # para fazer join do cluster
  map_public_ip_on_launch = true

  tags = {
    Name                       = "public-us-east-1a-mitu" # é publico, por isso o prefixo public
    "kubernets.io/cluster/eks" = "shared"            # permite ao eks cluster descobrir a subnet e a usar
    "kubernets.io/role/elb"    = 1                   # colocar os load balancers nas subnets.
  }
}

resource "aws_subnet" "public_2" {
  # VPC ID
  vpc_id = aws_vpc.main.id

  # bloco CIDR para a subnet
  cidr_block = "192.168.64.0/18"

  # AZ para a subnet
  availability_zone = "us-east-1b"

  # Requisitado pelo EKS. Toda nova instância que vai ser deployed na subnet pública
  # vai automaticamenete pegar o endereço do IP publico. Se eu quiser deploy do worker não na
  # subnet privada, mas sim na pública, todas as instâncias precisam ter os endereços  do IP publico
  # para fazer join do cluster
  map_public_ip_on_launch = true

  tags = {
    Name                       = "public-us-east-1b-mitu" # é publico, por isso o prefixo public
    "kubernets.io/cluster/eks" = "shared"            # permite ao eks cluster descobrir a subnet e a usar
    "kubernets.io/role/elb"    = 1                   # colocar os load balancers nas subnets.
  }
}

resource "aws_subnet" "private_1" {
  # VPC ID
  vpc_id = aws_vpc.main.id

  # bloco CIDR para a subnet
  cidr_block = "192.168.128.0/18"

  # AZ para a subnet
  availability_zone = "us-east-1a" # o mesmo que da public_1. Deployados no mesmo availability_zone

  # Requisitado pelo EKS. Toda nova instância que vai ser deployed na subnet pública
  # vai automaticamenete pegar o endereço do IP publico. Se eu quiser deploy do worker não na
  # subnet privada, mas sim na pública, todas as instâncias precisam ter os endereços  do IP publico
  # para fazer join do cluster
  map_public_ip_on_launch = true

  tags = {
    Name                             = "private-us-east-1a-mitu" # é publico, por isso o prefixo public
    "kubernets.io/cluster/eks"       = "shared"             # permite ao eks cluster descobrir a subnet e a usar
    "kubernets.io/role/internal-elb" = 1                    # colocar os private load balancers nas subnets
  }
}

resource "aws_subnet" "private_2" {
  # VPC ID
  vpc_id = aws_vpc.main.id

  # bloco CIDR para a subnet
  cidr_block = "192.168.192.0/18"

  # AZ para a subnet
  availability_zone = "us-east-1b" # o mesmo que da public_1. Deployados no mesmo availability_zone

  # Requisitado pelo EKS. Toda nova instância que vai ser deployed na subnet pública
  # vai automaticamenete pegar o endereço do IP publico. Se eu quiser deploy do worker não na
  # subnet privada, mas sim na pública, todas as instâncias precisam ter os endereços  do IP publico
  # para fazer join do cluster
  map_public_ip_on_launch = true

  tags = {
    Name                             = "private-us-east-1b-mitu" # é publico, por isso o prefixo public
    "kubernets.io/cluster/eks"       = "shared"             # permite ao eks cluster descobrir a subnet e a usar
    "kubernets.io/role/internal-elb" = 1                    # colocar os private load balancers nas subnets
  }
}


# Obs.: Usar as subnets públicasapenas para fazer deploy de load balancer publicos
# Por enquanto não são exatamente private e public subnets, eles são apenas containers para virar private e public