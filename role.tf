# https://docs.aws.amazon.com/AmazonS3/latest/dev/crr-how-setup.html#replication-iam-role-intro
resource "aws_iam_role" "replication" {
  provider = aws.primary

  name               = "s3-${var.primary_name}-replication"
  assume_role_policy = data.aws_iam_policy_document.s3-assume-role.json
}

resource "aws_iam_role_policy" "replication-primary" {
  provider = aws.primary

  name   = "primary"
  role   = aws_iam_role.replication.name
  policy = data.aws_iam_policy_document.primary.json
}

resource "aws_iam_role_policy" "replication-secondary" {
  provider = aws.primary

  name   = "secondary"
  role   = aws_iam_role.replication.name
  policy = data.aws_iam_policy_document.secondary.json
}
