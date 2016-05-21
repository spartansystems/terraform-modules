# S3 Bucket Users Module

A [terraform module](https://www.terraform.io/docs/modules/usage.html) for
easily creating an IAM user with access to only a single S3 bucket.

## Usage

Add the following to your terraform file. You will need to have the aws vars
defined as well as replace the bucket value with a comma seperated list of the
buckets for which you'd like to create IAM users (it will also work with a
single bucket).

```hcl
module "s3_bucket_users" {
  source = "github.com/spartansystems/terraform-modules//s3_bucket_users"
  buckets = "first_bucket,second_bucket"
  iam_user_group_name = "s3_bucket_users_group"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
}
```
