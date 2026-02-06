# SG
resource "aws_security_group" "instance_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id] 
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

# Lauhch Template
resource "aws_launch_template" "launch_template" {
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  user_data = base64encode(<<EOF
#!/bin/bash
set -euo pipefail
apt-get update -y
apt-get install -y apache2
systemctl enable --now apache2
echo "It's work!" > /var/www/html/index.html
EOF
  )
}

# ASG
resource "aws_autoscaling_group" "asg" {
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}
