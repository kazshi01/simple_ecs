resource "aws_ecs_cluster" "default" {
  name = "default-cluster"
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.default.id
  task_definition = "arn:aws:ecs:ap-northeast-1:996109426400:task-definition/nginx:5"
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [data.aws_subnet.default_public_subnet_a.id, data.aws_subnet.default_public_subnet_c.id]
    security_groups  = [data.aws_security_group.default_web_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue.arn
    container_name   = "nginx"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
