resource "aws_s3_bucket" "example" {
  bucket = "jmsth40-statefile"
  tags = {
    Managed     = "terraform"
    Environment = "Dev"
  }
}