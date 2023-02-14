resource "aws_route_table_association" "game_route_table_association" {
  subnet_id      = aws_subnet.game_subnet.id
  route_table_id = aws_route_table.game_route_table.id
}