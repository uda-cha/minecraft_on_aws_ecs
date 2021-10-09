resource "aws_eip" "minecraft-global-ip" {
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    Name = "minecraft-on-ecs"
  }
}

resource "aws_lb_target_group" "minecraft-ecs-target" {
  target_type = "ip"
  name        = "minecraft-ecs"
  protocol    = "TCP"
  port        = 25565
  vpc_id      = aws_vpc.ecs-default.id

  health_check {
    protocol = "TCP"
  }

  tags = {
    Name = "minecraft-on-ecs"
  }
}

resource "aws_lb" "minecraft-lb" {
  load_balancer_type = "network"
  name               = "minecraft-lb"
  internal           = false
  ip_address_type    = "ipv4"

  subnet_mapping {
    subnet_id     = aws_subnet.ecs-default.id
    allocation_id = aws_eip.minecraft-global-ip.id
  }

  tags = {
    Name = "minecraft-on-ecs"
  }
}

resource "aws_lb_listener" "minecraft-lb" {
  load_balancer_arn = aws_lb.minecraft-lb.id
  protocol          = "TCP"
  port              = "25565"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.minecraft-ecs-target.arn
  }

  tags = {
    Name = "minecraft-on-ecs"
  }
}
