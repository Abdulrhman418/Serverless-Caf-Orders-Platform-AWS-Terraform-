output "s3_bucket_name" {
  description = "Name of the S3 bucket for static website"
  value       = aws_s3_bucket.website_bucket.id
}

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.static_website_distrubution.id
}

output "cloudfront_distribution_domain_name" {
  description = "Domain name of the CloudFront distribution (use this to access the website)"
  value       = aws_cloudfront_distribution.static_website_distrubution.domain_name
}

output "origin_access_control_id" {
  description = "ID of the CloudFront Origin Access Control"
  value       = aws_cloudfront_origin_access_control.cloudfront_OAC.id
}
