
resource "aws_iam_user" "mysql2kinesis" {
    name = "mysql2kinesis"
    tags = {
        Environment = "${var.env}"
        Owner = "${var.app_name}"
  }
}
resource "aws_iam_access_key" "mysql2kinesis" {
  user = "${aws_iam_user.mysql2kinesis.name}"
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = "${aws_iam_user.mysql2kinesis.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}

output "user_arn" {
  value = "${aws_iam_user.mysql2kinesis.arn}"
}
