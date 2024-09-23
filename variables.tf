variable "default_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to all AWS resources created by this module.
EOS
}

variable "force_destroy" {
  type    = string
  default = false

  description = <<EOS
Whether the deletion of the buckets created by this module will enforce the deletion of all objects.

If this option is set to `false` and the buckets are not empty the deletion of the buckets will fail.
EOS
}

variable "primary_name" {
  type = string

  description = <<EOS
Name of bucket in created via the `aws.primary` AWS provider.
EOS
}

variable "primary_s3_bucket_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to the primary S3 bucket.
EOS
}

variable "secondary_name" {
  type = string

  description = <<EOS
Name of bucket in created via the `aws.secondary` AWS provider.
EOS
}

variable "secondary_s3_bucket_tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to the secondary S3 bucket.
EOS
}
