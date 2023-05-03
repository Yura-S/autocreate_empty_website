resource "aws_s3_bucket" "tf-state" {
  bucket        = "my-tf-state7777"
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.tf-state.id
  versioning_configuration {
    status = "Enabled"
  }
}
