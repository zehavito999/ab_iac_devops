data "aws_vpc" "default"{
  default = true
}

resource "aws_lb" "nlb" {
  name                             = var.lb_name
  subnets                          = var.subnets
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "nlb_tg" {
  name = "nlb-tg"
  port = "3000"
  protocol = "TCP"
  target_type = "ip"
  vpc_id = data.aws_vpc.default.id
  deregistration_delay = "30"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "TCP"
    interval            = 30
  }
}

resource "aws_lb_target_group" "nlb_tg_1" {
  name = "nlb-tg-1"
  port = "3000"
  protocol = "TCP"
  target_type = "ip"
  vpc_id = data.aws_vpc.default.id
  deregistration_delay = "30"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "TCP"
    interval            = 30
  }
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port = "80"
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
  }
}
