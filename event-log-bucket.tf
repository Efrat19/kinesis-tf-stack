resource "aws_s3_bucket" "event_log_bucket" {
  bucket = "${var.event_log_bucket_name}"
  acl    = "private"
    versioning {
    enabled = true
  }
#   storage_class = "STANDARD_IA"
}
resource "aws_s3_bucket_object" "athena" {
    bucket = "${aws_s3_bucket.event_log_bucket.id}"
    acl    = "private"
    key = "athena-test/"
    source = "/dev/null"
}