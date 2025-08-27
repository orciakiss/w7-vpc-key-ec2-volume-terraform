resource "aws_s3_bucket" "s3" {
  bucket = "w7-dsg-ok"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}