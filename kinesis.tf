
provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
  version = "~> 2.7"
  access_key = ""
  secret_key = ""
}


resource "aws_kinesis_stream" "stream1" {
  name             = "${var.app_name}-stream"
  shard_count      = "${var.shard_count}"
  retention_period = "${var.retention_period}"
  shard_level_metrics = "${var.shard_level_metrics}"
  tags = {
    Environment = "${var.env}"
    Owner = "${var.app_name}"
  }
}


output "kinesis_stream_arn" {
  value = "${aws_kinesis_stream.stream1.arn}"
}

output "kinesis_stream_name" {
  value = "${aws_kinesis_stream.stream1.name}"
}

output "kinesis_stream_id" {
  value = "${aws_kinesis_stream.stream1.id}"
}
