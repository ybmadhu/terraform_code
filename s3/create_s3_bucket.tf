provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "example" {
  bucket        = "jmsth39-40-sample-bucket-1"
  force_destroy = true
  tags = {
    Managed     = "terraform"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_object" "test" {

  for_each = fileset("${path.module}/files", "**")
  bucket   = aws_s3_bucket.example.id

  key          = each.value
  source       = "${path.module}/files/${each.value}"
  content_type = "text/html"
  etag         = filemd5("${path.module}/files/${each.value}")


}




resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "public-read"
}
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}
resource "aws_s3_bucket_policy" "allow_access_public" {
  bucket = aws_s3_bucket.example.id
  policy = <<POLICY
  {
    "Id": "Policy1648530092149",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1648530090294",
        "Action": [
          "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::jmsth39-40-sample-bucket-1/*",
        "Principal": "*"
      }
    ]
  }
POLICY
}

output "mywebsite" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}
