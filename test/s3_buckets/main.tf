module "s3_buckets" {
  source = "../../s3_buckets"
  buckets = "first_test_bucket,second_test_bucket"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region = "${var.aws_region}"
}
