resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_name
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name = "ecs_task_execution_role_policy"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ssm:GetParameters",
        "ssm:GetParameter"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family             = var.task_def_name
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  cpu                = 256
  memory             = 512
  network_mode       = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]
  container_definitions = <<DEFINITION
[
  {
    "essential": true,
    "image": "${aws_ecr_repository.ecr_registry.repository_url}:latest",
    "name": "${var.ecs_task_container_name}",
    "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
               "awslogs-group" : "${var.ecs_task_container_name}",
               "awslogs-region": "${var.aws_region}",
               "awslogs-stream-prefix": "ecs"
            }
     },
    "healthCheck": {
       "command": [ "CMD-SHELL", "curl -f http://localhost:3000/ || exit 1" ],
       "interval": 30,
       "retries": 3,
       "timeout": 5
     },
    "portMappings": [
       {
          "containerPort": 3000,
          "protocol": "tcp"
       }
    ],
    "memory": 512,
    "cpu": 256
  }
]
DEFINITION
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.ecs_service_name}"
  cluster         = "${aws_ecs_cluster.ecs_cluster.id}"
  desired_count   = 3
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.arn}"
  launch_type     = "FARGATE"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = var.subnets
    security_groups = [aws_security_group.service_security_group.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nlb_tg.arn
    container_name   = var.ecs_task_container_name
    container_port   = 3000
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer
    ]
  }
}

resource "aws_security_group" "service_security_group" {
  name = "ecs-service-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port = 3000
    protocol = "tcp"
    to_port = 3000
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = var.ecs_task_container_name
}