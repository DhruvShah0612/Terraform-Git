resource "random_id" "bucket_id" {
  byte_length = 4
}

module "s3_bucket" {
  source  = "github.com/terraform-aws-modules/terraform-aws-s3-bucket"

  bucket = "dhruv-auto-s3-${random_id.bucket_id.hex}"

  acl    = null

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"

  versioning = {
    enabled = true
  }

  tags = {
    Environment = "dev"
    Owner       = "Dhruv Shah"
  }
}
