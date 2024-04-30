
resource "aws_instance" "stagging" {
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.nano"
  key_name      = aws_key_pair.my_key.key_name
  count         = 1
  tags = {
    Name = element(var.tags, count.index)
  }
}
