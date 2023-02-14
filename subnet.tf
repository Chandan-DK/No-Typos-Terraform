resource "aws_subnet" "game_subnet" {
  availability_zone = "ap-south-1a"
  vpc_id            = aws_vpc.game_vpc.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "game_subnet"
  }
}