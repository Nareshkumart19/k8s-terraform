# Security grops

module "ingress_alb" {
    #source = "../../naresh-terraform-aws-securitygroup"
    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    
    sg_name = "ingress-alb"
    sg_description = "for ingress alb"
    vpc_id = local.vpc_id
}

module "bastion" {
    #source = "../../naresh-terraform-aws-securitygroup"
    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    
    sg_name = var.bastion_sg_name
    sg_description = var.bastion_sg_description
    vpc_id = local.vpc_id
}

module "eks_control_plane" {
    #source = "../../naresh-terraform-aws-securitygroup"
    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    
    sg_name = "eks_control_plane"
    sg_description = "for eks_control_plane"
    vpc_id = local.vpc_id
}

module "eks_node" {
    #source = "../../naresh-terraform-aws-securitygroup"
    source = "git::https://github.com/Nareshkumart19/naresh-terraform-aws-securitygroup.git?ref=main"
    project = var.project
    environment = var.environment
    
    sg_name = "eks_node"
    sg_description = "eks_node"
    vpc_id = local.vpc_id
}


#================= port openings


resource "aws_security_group_rule" "ingress_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.ingress_alb.sg_id
}

resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

resource "aws_security_group_rule" "eks_control_plane_eks_node" {
  type             = "ingress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  source_security_group_id = module.eks_node.sg_id
  security_group_id = module.eks_control_plane.sg_id
}

resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type              = "ingress"
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  source_security_group_id = module.eks_control_plane.sg_id
  security_group_id = module.eks_node.sg_id
}

resource "aws_security_group_rule" "eks_node_bastion" {
  type              = "ingress"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.eks_node.sg_id
}

resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.eks_control_plane.sg_id
}












































































































































































