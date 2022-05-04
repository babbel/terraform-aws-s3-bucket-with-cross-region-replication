output "primary" {
  value = aws_s3_bucket.primary

  description = "The primary S3 bucket"
}

output "secondary" {
  value = aws_s3_bucket.secondary

  description = "The secondary S3 bucket"
}
