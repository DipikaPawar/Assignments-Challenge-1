#======================
# ALB Exteral 
#======================

resource "aws_lb" "alb-e" {
  
  name = "aws-alb-e-${var.application_name}-${var.environment}-web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.alb-e-sg.id ]
  subnets            = var.alb-e-subnet
  
  ip_address_type = "ipv4"

  tags = {
    Name = "aws-alb-e-${var.application_name}-${var.environment}-web"
    Description = "application load balancer for ${var.application_name} ${var.environment} environment web tier"
    Environment = var.environment
  }
}


## security group for alb
resource "aws_security_group" "alb-e-sg" {
  description = "singtel alb security group"
  name = "aws-sg-${var.application_name}-${var.environment}-alb-e"
  vpc_id      = var.vpc_id
  tags = {
    Name = "aws-sg-${var.application_name}-${var.environment}-alb-e"
    Description = "security group for alb in ${var.application_name} ${var.environment} environment"
    Environment = var.environment
  }
}


resource "aws_security_group_rule" "albe2" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  security_group_id = aws_security_group.alb-e-sg.id
  cidr_blocks = ["0.0.0.0/0"]
  description = "All incoming"
}


resource "aws_security_group_rule" "albe3" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = -1
  security_group_id = aws_security_group.alb-e-sg.id
  cidr_blocks     = ["0.0.0.0/0"]
}

#  ALB Listener 
# ------------------------------------------------------------


############## listner and listener rules for external HTTP

resource "aws_lb_listener" "alb_web_e_listener_http_80" {
  load_balancer_arn = "${aws_lb.alb-e.arn}"
  port              = "80"
  protocol          = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.alb-web-e-target-group-http-80.arn}"
  }
}
