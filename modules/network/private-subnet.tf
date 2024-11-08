resource "aws_subnet" "eks_subnet_private_1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone       = "${data.aws_region.current.name}a"
  map_public_ip_on_launch = false

  tags = merge(
    local.tags,
    {
      Name                              = "${var.project_name}-pri-subA",
      "kubernetes.io/role/internal-elb" = 2
    }
  )
}


resource "aws_subnet" "eks_subnet_private_1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone       = "${data.aws_region.current.name}b"
  map_public_ip_on_launch = false

  tags = merge(
    local.tags,
    {
      Name                              = "${var.project_name}-pri-subB",
      "kubernetes.io/role/internal-elb" = 2
    }
  )
}
