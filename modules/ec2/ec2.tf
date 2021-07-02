resource "aws_launch_template" "launch_template_main" {
  name_prefix   = var.ec2_names
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_main_sg.id]
  user_data = filebase64("${path.module}/user_data.sh")
  key_name = var.key_name
  iam_instance_profile {
    arn = aws_iam_instance_profile.instance_profile_main.arn
  }
}

resource "aws_autoscaling_group" "asg_main" {
  name = var.ec2_names
  vpc_zone_identifier = var.subnet_main
  target_group_arns = [ var.alb_tg ]
  desired_capacity   = var.asg_desired_capacity
  max_size           = var.asg_max_size
  min_size           = var.asg_min_size

  launch_template {
    id      = aws_launch_template.launch_template_main.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "bat" {
  name                   = "${var.ec2_names}-asg-policy"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_main.name
}

resource "aws_iam_role" "iam_role_main" {
  name = "aws-iamrole-${var.application_name}-${var.environment}-${var.ec2_names}"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile_main" {
  name = "aws-iamprof-${var.application_name}-${var.environment}-${var.ec2_names}"
  role = aws_iam_role.iam_role_main.name
}
 

resource "aws_iam_role_policy_attachment" "iam_role_main_attach" {
  count = length(var.policy_list)
  role = aws_iam_role.iam_role_main.name 
  policy_arn = "arn:aws:iam::aws:policy/${var.policy_list[count.index]}"
}



resource "aws_security_group" "ec2_main_sg" {
  description = "security group for ${var.ec2_names} in ${var.application_name} ${var.environment} environment"
  name = "aws-sg-${var.application_name}-${var.environment}-${var.ec2_names}"
  vpc_id      = var.vpc_main
  tags = {
    Name = "aws-sg-${var.application_name}-${var.environment}-${var.ec2_names}"
    Description = "security group for ${var.ec2_names} in ${var.application_name} ${var.environment} environment"
    Environment = var.environment
  }
}



resource "aws_security_group_rule" "ec2_ingress_rules" {

  type              = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks       = var.subnet_cidr_public
  description       = "http from public subnets"
  security_group_id = aws_security_group.ec2_main_sg.id
}

resource "aws_security_group_rule" "ec2_ingress_rules_ssh" {

  type              = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks       = var.subnet_cidr_public
  description       = "ssh from public subnets"
  security_group_id = aws_security_group.ec2_main_sg.id
}

resource "aws_security_group_rule" "ec2_egress_rules" {

  type              = "egress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks       = var.subnet_cidr_public
  description       = "http from public subnets"
  security_group_id = aws_security_group.ec2_main_sg.id
}
