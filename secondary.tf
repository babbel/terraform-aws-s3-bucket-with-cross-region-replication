resource "aws_s3_bucket" "secondary" {
  provider = aws.secondary

  bucket = var.secondary_name

  force_destroy = var.force_destroy

  tags = merge(var.default_tags, var.secondary_s3_bucket_tags)
}

resource "aws_s3_bucket_versioning" "secondary" {
  provider = aws.secondary

  bucket = aws_s3_bucket.secondary.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "secondary" {
  provider = aws.secondary

  statement {
    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = ["${aws_s3_bucket.secondary.arn}/*"]
  }
}
