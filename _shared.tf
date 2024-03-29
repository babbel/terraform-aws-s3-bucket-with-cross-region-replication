data "aws_iam_policy_document" "s3-assume-role" {
  provider = aws.primary

  statement {
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
