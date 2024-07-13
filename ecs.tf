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
    subnets          = [data.aws_subnet.default_public_subnet_a.id]
    security_groups  = [data.aws_security_group.default_web_sg.id]
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
