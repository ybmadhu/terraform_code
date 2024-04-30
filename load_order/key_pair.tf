
resource "aws_key_pair" "my_key" {
  key_name   = "login-key"
  public_key = file("${path.module}/jmsth39-40.pub")
}