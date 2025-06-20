variable "bucket" {}
variable "acl" {}
variable "control_object_ownership" {}
variable "object_ownership" {}
variable "versioning" {}
variable "tags" {}

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket
  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning.enabled ? "Enabled" : "Suspended"
  }
}
