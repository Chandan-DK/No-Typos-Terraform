resource "aws_vpc" "game_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "game_vpc"
  }
}