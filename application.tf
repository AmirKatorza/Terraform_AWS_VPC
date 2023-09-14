# Step 1: Create a Target Group
resource "aws_lb_target_group" "amirk-tf-tg" {
  name     = "amirk-tf-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.amirk-tf-vpc.id
}

# Associate EC2 instances with the Target Group
resource "aws_lb_target_group_attachment" "amirk-tf-tg-attach-1a" {
  target_group_arn = aws_lb_target_group.amirk-tf-tg.arn
  target_id        = aws_instance.amirk-tf-node-1a.id
}

resource "aws_lb_target_group_attachment" "amirk-tf-tg-attach-1b" {
  target_group_arn = aws_lb_target_group.amirk-tf-tg.arn
  target_id        = aws_instance.amirk-tf-node-1b.id
}

# Step 2: Create the Application Load Balancer (ALB)
resource "aws_lb" "amirk-tf-alb" {
  name               = "amirk-tf-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.amirk-tf-sg.id]
  subnets            = [aws_subnet.amirk-tf-public-subnet-1a.id, aws_subnet.amirk-tf-public-subnet-1b.id]

  enable_deletion_protection = false

  tags = {
    Name = "amirk-tf-alb"
  }
}

# Step 3: Create a Listener for the ALB
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.amirk-tf-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.amirk-tf-tg.arn
  }
}
