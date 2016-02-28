# S3 Buckets Module

A [terraform module](https://www.terraform.io/docs/modules/usage.html) for
easily creating S3 buckets along with an IAM user that only has permissions to
access the new bucket of the same name. For example, a bucket named "my_bucket"
would also create a IAM user "my_bucket" that only has access to the S3 bucket
"my_bucket".

## Usage

Add the following to your terraform file. You will need to have the aws vars
defined as well as replace the bucket value with a comma seperated list of the
buckets you'd like to create (it will also work with a single bucket).

```hcl
module "s3_buckets" {
  source = "github.com/spartansystems/terraform-modules//s3_buckets"
  buckets = "first_bucket,second_bucket"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
}
```
