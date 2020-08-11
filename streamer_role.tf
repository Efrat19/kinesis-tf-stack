# resource "aws_iam_role" "kinesis_rds_integration" {
#     name = "kinesis_rds_integration"
#     assume_role_policy = "${data.aws_iam_policy_document.kinesis_stream_full_access.json}"
#     tags = {
#         Environment = "${var.env}"
#         Owner = "${var.app_name}"
#   }
# }

# data "aws_iam_policy_document" "kinesis_stream_full_access" {
#   statement {
#     actions = [
#         "sts:AssumeRole",
#          "kinesis:*",
#         ]

#     # principals {
#     #   type        = "Service"
#     #   identifiers = ["ec2.amazonaws.com"]
#     # }

#     resources = [
#       "*"
#     ]

#   }
# }         
