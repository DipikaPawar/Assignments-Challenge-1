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



#  ALB Target group 
# ------------------------------------------------------------

########### Target groups and Target group attachement for HTTP 80

resource "aws_lb_target_group" "alb-web-e-target-group-http-80" {
  name = "aws-tg-${var.application_name}-${var.environment}-web-e"
  port     = 80
  protocol = "HTTP" 
  vpc_id   = var.vpc_id
  stickiness {    
    type            = "lb_cookie"    
    cookie_duration =  1800   
    enabled         =  true
  }
  health_check {
    enabled             = true
    interval            = 30 # 300
    path                = "/index.html"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5       # 120
    healthy_threshold   = 5        # 2
    unhealthy_threshold = 3        # 2
    matcher             = "200" # "200"
  }
  tags = {
    Name = "aws-tg-${var.application_name}-${var.environment}-web-e"
    Description = "target group for ${var.application_name} ${var.environment} environment for web servers running on http"
    Environment = var.environment
  }
}
