# S3 buckets with cross-region replication

This module creates two versioned S3 buckets in different regions with cross-region replication.

The replication configuration created by this module is V2, see
[Replication configuration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/replication-add-config.html) for details. **Delete marker replication is enabled.**

## Usage

Example:

```tf
module "s3-backups-foo" {
  source  = "babbel/s3-bucket-with-cross-region-replication/aws"
  version = "~> 1.0"

  providers = {
    aws.primary   = aws.eu-west-1
    aws.secondary = aws.eu-central-1
  }

  primary_name   = "example-primary"
  secondary_name = "example-secondary"

  tags = {
    app = "example"
    env = "production"
  }
}
```

## Customizing the buckets

Both buckets are provided as outputs – so you can further customize them
outside of this module.

:warning: Please note: You cannot customize the bucket versioning.
The versioning configuration provided by this module is required for
the replication to work.

<details>
<summary>Configuring server-side encryption</summary>

```tf
module "s3-backups-foo" {
  # see above
}

resource "aws_s3_bucket_server_side_encryption_configuration" "primary" {
  provider = aws.primary

  bucket = module.s3-backups-foo.primary.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
```

</details>

<details>
<summary>Configuring an object lifecycle</summary>

```tf
module "s3-backups-foo" {
  # see above
}

resource "aws_s3_bucket_lifecycle_configuration" "primary" {
  provider = aws.primary

  bucket = module.s3-backups-foo.primary.bucket

  rule {
    id     = "expire"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
```

</details>

<details>
<summary>Configuring the policy for the primary bucket</summary>

```tf
module "s3-backups-foo" {
  # see above
}

resource "aws_s3_bucket_policy" "primary" {
  provider = aws.primary

  bucket = module.s3-backups-foo.primary.bucket
  policy = "YOUR POLICY HERE"
}
```

</details>

<details>
<summary>Configuring an ACL for the primary bucket</summary>

You can add
[canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl)
to the buckets, or set up your own grants, using an `aws_s3_bucket_acl` resource.

```tf
module "s3-backups-foo" {
  # see above
}

resource "aws_s3_bucket_acl" "primary" {
  provider = aws.primary

  bucket = module.s3-backups-foo.primary.bucket
  acl    = "private"
}
```

</details>

<details>
<summary>Configuring a public access block for both buckets</summary>

```tf
module "s3-backups-foo" {
  # see above
}

resource "aws_s3_bucket_public_access_block" "primary" {
  provider = aws.primary

  bucket = module.s3-backups-foo.primary.bucket

  block_public_acls  = true
  ignore_public_acls = true

  block_public_policy     = true
  restrict_public_buckets = true
}
```

</details>
