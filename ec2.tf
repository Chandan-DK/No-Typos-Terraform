resource "aws_instance" "game_instance" {
  ami               = "ami-01a4f99c4ac11b03c"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  subnet_id         = aws_subnet.game_subnet.id
  # This is used to auto assign a public ip address
  associate_public_ip_address = "true"
  security_groups             = [aws_security_group.game_security_group.id]
  tags = {
    Name = "game_instance"
  }
  user_data = file(var.user_data_file_path)
}