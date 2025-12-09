resource "aws_ecr_repository" "demo" {
  name = "ardin-ecs-demo"
}

# ECS Cluster
resource "aws_ecs_cluster" "demo" {
  name = "ardin-ecs-cluster"
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_exec" {
  name = "ecsTaskExecutionRole-demo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_exec_policy" {
  role       = aws_iam_role.ecs_task_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "demo" {
  family                   = "ardin-ecs-task"
  execution_role_arn       = aws_iam_role.ecs_task_exec.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = jsonencode([{
    name      = "nana-app"
    image     = image = "${aws_ecr_repository.demo.repository_url}:${var.image_tag}"

    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
  lifecycle {
  create_before_destroy = true
}

}

# ECS Service
resource "aws_ecs_service" "demo" {
  name            = "nana-ecs-service"
  cluster         = aws_ecs_cluster.demo.id
  task_definition = aws_ecs_task_definition.demo.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
    assign_public_ip = true
  }
}
