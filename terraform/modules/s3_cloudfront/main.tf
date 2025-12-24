
# create s3 for hosting static website
resource "aws_s3_bucket" "website_bucket" {
  bucket              = var.s3_bucket_name
  
}


# assciate s3 bucket policy
resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

# create cloudfront orgin acces control
resource "aws_cloudfront_origin_access_control" "cloudfront_OAC" {
  name                              = var.origin_access_control.name
  description                       = var.origin_access_control.description
  origin_access_control_origin_type = var.origin_access_control.origin_type
  signing_behavior                  = var.origin_access_control.signing_behavior
  signing_protocol                  = var.origin_access_control.signing_protocol
}

# create cloudfront distribution
resource "aws_cloudfront_distribution" "static_website_distrubution" {
  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id                = var.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_OAC.id
  }

  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]


    target_origin_id = var.s3_origin_id

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = "MyStaticWebsiteCDN"
  }
}
