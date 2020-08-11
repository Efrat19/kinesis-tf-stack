
resource "aws_iam_role" "firehose_assume_role" {
  name = "firehose_assume_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# resource "aws_iam_role" "kinesis_consumer" {
#   name = "kinesis_consumer"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "kinesis:DescribeStream"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

resource "aws_iam_role_policy" "kinesis_consumer" {
  name = "test_policy"
  role = "${aws_iam_role.firehose_assume_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kinesis:DescribeStream"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "terraform-kinesis-firehose-test-stream"
  destination = "s3"

  kinesis_source_configuration {
      kinesis_stream_arn = "${aws_kinesis_stream.stream1.arn}"
      role_arn   = "${aws_iam_role.firehose_assume_role.arn}"
  } 

  s3_configuration {
    role_arn   = "${aws_iam_role.firehose_assume_role.arn}"
    bucket_arn = "${aws_s3_bucket.event_log_bucket.arn}"
    compression_format = "GZIP"
  }
}