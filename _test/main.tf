module "s3-cross-region-replication" {
  source = "./.."

  providers = {
    aws.primary   = aws.primary
    aws.secondary = aws.secondary
  }

  primary_name   = "source-bucket"
  secondary_name = "destination-bucket"
}
