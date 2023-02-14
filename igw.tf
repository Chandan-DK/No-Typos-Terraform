resource "aws_internet_gateway" "game_gw" {
  vpc_id = aws_vpc.game_vpc.id

  tags = {
    Name = "game_gw"
  }
}