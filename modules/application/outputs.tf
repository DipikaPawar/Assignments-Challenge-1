output "alb_e_dns" {
  value = aws_lb.alb-e.dns_name
}

output "alb_tg" {
  value = aws_lb_target_group.alb-web-e-target-group-http-80.arn
}
