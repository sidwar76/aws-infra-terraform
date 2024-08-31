module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block     = "17.1.0.0/25"
  subnet_cidr_blocks = ["17.1.0.0/26", "17.1.0.64/26"]
  availability_zones = ["us-east-1a", "us-east-1b"]  # Replace with actual AZs
}


module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.subnet_ids
  security_group_id  = aws_security_group.allow_all.id
  ami_id             = "ami-0ae8f15ae66fe8cda" # Replace with your AMI ID
  instance_profile   = aws_iam_instance_profile.my_instance_profile.id
  target_group_arn   = module.load_balancer.target_group_arn # Ensure this is the correct output
}

module "load_balancer" {
  source            = "./modules/load_balancer"
  subnet_ids        = module.vpc.subnet_ids
  security_group_id = aws_security_group.allow_all.id
  target_group_arn  = module.ec2.target_group_arn
  vpc_id            = module.vpc.vpc_id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "my_instance_profile" {
  name = "my_instance_profile"
  role = aws_iam_role.my_role.name
}

resource "aws_iam_role" "my_role" {
  name = "my_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

