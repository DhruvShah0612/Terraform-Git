resource "aws_s3_bucket" "this" {
  bucket = var.bucket
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning.enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.object_ownership
  }
}

variable "bucket" {}
variable "versioning" {
  type = object({ enabled = bool })
}
variable "object_ownership" {}
