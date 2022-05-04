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

variable "secondary_name" {
  type = string

  description = <<EOS
Name of bucket in created via the `aws.secondary` AWS provider.
EOS
}

variable "tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Tags to be assigned to the buckets.
EOS
}
