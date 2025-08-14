variable "aws_region" {
  default = "ap-south-1"
}

variable "key_name" {
  description = "EC2 key pair name"
  default     = "my-key"
}

variable "jenkins_instance_type" {
  default = "t3.micro"
}

variable "worker_instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI"
  default     = "ami-0f5ee92e2d63afc18"
}
