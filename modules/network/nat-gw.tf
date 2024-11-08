resource "aws_eip" "eks_ngw_eip_1a" {
  domain = "vpc" #vpc = true
  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-eip-1a",
      "kubernetes.io/role/elb" = 2
    }
  )
}

resource "aws_eip" "eks_ngw_eip_1b" {
  domain = "vpc" #vpc = true
  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-eip-1b",
      "kubernetes.io/role/elb" = 2
    }
  )
}

resource "aws_nat_gateway" "eks_ngw_1a" {
  allocation_id = aws_eip.eks_ngw_eip_1a.id
  subnet_id     = aws_subnet.eks_subnet_public_1a.id

  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-nat-gw-1a",
      "kubernetes.io/role/elb" = 2
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_nat_gateway" "eks_ngw_1b" {
  allocation_id = aws_eip.eks_ngw_eip_1b.id
  subnet_id     = aws_subnet.eks_subnet_public_1b.id

  tags = merge(
    local.tags,
    {
      Name                     = "${var.project_name}-nat-gw-1b",
      "kubernetes.io/role/elb" = 2
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.eks_igw]
}

resource "aws_route_table" "eks-private_route_table_1a" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_ngw_1a.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-private-route-table-1a"
    }
  )
}

resource "aws_route_table" "eks-private_route_table_1b" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_ngw_1b.id
  }

  tags = merge(
    local.tags,
    {
      Name = "${var.project_name}-private-route-table-1b"
    }
  )
}

resource "aws_route_table_association" "eks_rtb_assoc_private_1a" {
  subnet_id      = aws_subnet.eks_subnet_private_1a.id
  route_table_id = aws_route_table.eks-private_route_table_1a.id
}

resource "aws_route_table_association" "eks_rtb_assoc_private_1b" {
  subnet_id      = aws_subnet.eks_subnet_private_1b.id
  route_table_id = aws_route_table.eks-private_route_table_1b.id
}