variable "s3_bucket_name" {
  description = "name of bucket"
  type = string
  default = "my-static-website-bucket-54343"
}

variable "origin_access_control" {
  description = "Map of CloudFront origin access control"
  type = object({
    name             = optional(string)
    description      = string
    origin_type      = string
    signing_behavior = string
    signing_protocol = string
  })

  default = {
    name             = "cloudfront_OAC",
    description      = "Origin Access Control for S3 bucket access from CloudFront",
    origin_type      = "s3",
    signing_behavior = "always",
    signing_protocol = "sigv4"
  }
}
variable "s3_origin_id" {
  description = "s3 origin for cloudfront"
  type = string
  default = "S3-my-website-bucket"
}