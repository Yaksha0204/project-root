provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "project_sg" {
  name        = "project_sg"
  description = "Allow SSH, HTTP, Jenkins"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  ami                    = var.ami_id
  instance_type          = var.jenkins_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.project_sg.id]
  user_data              = file("${path.module}/jenkins_user_data.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}

resource "aws_instance" "worker" {
  ami                    = var.ami_id
  instance_type          = var.worker_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.project_sg.id]
  user_data              = file("${path.module}/worker_user_data.sh")

  tags = {
    Name = "Worker-Server"
  }
}
