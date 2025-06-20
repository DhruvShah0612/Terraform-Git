module "remote_s3" {
  source = "git::https://github.com/DhruvShah0612/Terraform-Git.git//modules/s3?ref=v1.0.0"

  bucket                     = "dhruv-remote-s3-${random_id.remote_id.hex}"
  acl                        = null
  control_object_ownership  = true
  object_ownership           = "BucketOwnerEnforced"

  versioning = {
    enabled = true
  }

  tags = {
    Environment = "prod"
    Owner       = "Dhruv Shah"
  }
}

resource "random_id" "remote_id" {
  byte_length = 4
}
