resource "aws_s3_bucket" "my-s3-bucket" {
  bucket = var.bucket_name
  acl = var.acl
  
   versioning {
    enabled = var.versioning
  }
  
  tags = var.tags
}

