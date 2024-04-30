
resource "aws_iam_user" "uname" {
  name = var.username
  path = "/system/"

  tags = {
    tag-key = "dev-user"
  }
}

