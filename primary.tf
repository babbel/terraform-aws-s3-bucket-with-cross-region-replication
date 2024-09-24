resource "aws_s3_bucket" "primary" {
  provider = aws.primary

  bucket = var.primary_name

  force_destroy = var.force_destroy

  tags = merge(var.default_tags, var.primary_s3_bucket_tags)
}

resource "aws_s3_bucket_versioning" "primary" {
  provider = aws.primary

  bucket = aws_s3_bucket.primary.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "primary" {
  provider = aws.primary

  depends_on = [aws_s3_bucket_versioning.primary]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.primary.bucket


  rule {
    id = aws_s3_bucket.secondary.bucket

    filter {} # rule requires no filter but attr must be specified

    status = "Enabled"

    delete_marker_replication {
      status = "Enabled"
    }

    destination {
      bucket = aws_s3_bucket.secondary.arn
    }
  }
}

data "aws_iam_policy_document" "primary" {
  provider = aws.primary

  statement {
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket",
    ]

    # Don't use Terraform reference to bucket's ARN here as this would produce a circular dependency:
    # bucket depends on role depends on policy depends on this data source depends on bucket's ARN
    resources = ["arn:aws:s3:::${var.primary_name}"]
  }

  statement {
    actions = [
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    # Don't use Terraform reference to bucket's ARN here as this would produce a circular dependency:
    # bucket depends on role depends on policy depends on this data source depends on bucket's ARN
    resources = ["arn:aws:s3:::${var.primary_name}/*"]
  }
}
