resource "aws_route_table" "game_route_table" {
  vpc_id = aws_vpc.game_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.game_gw.id
  }

  tags = {
    Name = "game_route_table"
  }
}