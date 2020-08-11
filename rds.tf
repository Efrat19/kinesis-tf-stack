# module "db" {
#   source  = "terraform-aws-modules/rds/aws"
#   version = "~> 2.0"

#   identifier = "${var.app_name}-demodb"

#   engine            = "mysql"
#   engine_version    = "5.7.19"
#   instance_class    = "db.t2.small"
#   allocated_storage = 5

#   name     = "demodb"
#   username = "root"
#   password = "YourPwdShouldBeLongAndSecure!"
#   port     = "3306"

#   iam_database_authentication_enabled = false

  
#   # DB parameter group
#   family = "mysql5.7"

#   # DB option group
#   major_engine_version = "5.7"

#   # Snapshot name upon DB deletion
#   final_snapshot_identifier = "demodb"

#   # Database Deletion Protection
#   deletion_protection = false

#   parameters = [
#     {
#       name = "character_set_client"
#       value = "utf8"
#     },
#     {
#       name = "character_set_server"
#       value = "utf8"
#     },
#     {
#         name = "binlog_format"
#         value = "ROW"
#     }
#   ]

#   options = [
#     {
#       option_name = "MARIADB_AUDIT_PLUGIN"

#       option_settings = [
#         {
#           name  = "SERVER_AUDIT_EVENTS"
#           value = "CONNECT"
#         },
#         {
#           name  = "SERVER_AUDIT_FILE_ROTATIONS"
#           value = "37"
#         },
#       ]
#     },
#   ]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

#     tags = {
#         Environment = "${var.env}"
#         Owner = "${var.app_name}"
#     }




#   # Enhanced Monitoring - see example for details on how to create the role
#   # by yourself, in case you don't want to create it automatically
#   monitoring_interval = "0"
#   monitoring_role_name = "MyRDSMonitoringRole"
#   create_monitoring_role = true

#     # DB subnet group
#   subnet_ids = ["${aws_subnet.event-streaming-rds-subnet1.id}", "${aws_subnet.event-streaming-rds-subnet2.id}"]
# #   db_subnet_group_name = "${aws_db_subnet_group.rds_subnet_group.id}"
#   vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]

# }

# resource "aws_subnet" "event-streaming-rds-subnet1" {
#   vpc_id     = "${var.vpc_id}"
#   cidr_block = "10.120.123.0/25"
# availability_zone = "eu-west-1a"
#     tags = {
#         Environment = "${var.env}"
#         Owner = "${var.app_name}"
#     }

# }

# resource "aws_subnet" "event-streaming-rds-subnet2" {
#   vpc_id     = "${var.vpc_id}"
#   cidr_block = "10.120.123.128/25"
# availability_zone = "eu-west-1b"
#     tags = {
#         Environment = "${var.env}"
#         Owner = "${var.app_name}"
#     }
    

# }

# resource "aws_route_table" "allow-dev" {
#     vpc_id = "${var.vpc_id}"

#   route {
#     cidr_block = "10.130.0.0/24"
#     gateway_id = "${var.transit_gateway_id}"
#   }
#     tags = {
#         Environment = "${var.env}"
#         Owner = "${var.app_name}"
#     }
# }



# resource "aws_route_table_association" "ta" {
#   subnet_id      = "${aws_subnet.event-streaming-rds-subnet1.id}"
#   route_table_id = "${aws_route_table.allow-dev.id}"
# }


# resource "aws_route_table_association" "ta2" {
#   subnet_id      = "${aws_subnet.event-streaming-rds-subnet2.id}"
#   route_table_id = "${aws_route_table.allow-dev.id}"
# }

# # resource "aws_db_subnet_group" "rds_subnet_group" {
# #   name       = "${var.app_name}_rds_subnet_group"
# #   subnet_ids = ["${aws_security_group.rds_sg.id}"]

# #     tags = {
# #         Environment = "${var.env}"
# #         Owner = "${var.app_name}"
# #     }

# # }

# # resource "aws_db_security_group" "rds_sg" {
# #   name = "${var.app_name}_rds_sg"
# #   vpc_id     = "${var.vpc_id}"
# #   ingress {
# #     cidr = "10.0.0.0/8"
# #   }
# # }

# resource "aws_security_group" "rds_sg" {
#   name        = "${var.app_name}_sg"
#   description = "sg for the rds"
#   vpc_id      = "${var.vpc_id}"

#   ingress {
#     from_port   = 3306
#     to_port   = 3306
#     protocol    = "TCP"
#     cidr_blocks = ["10.0.0.0/8"]
#   }

#   egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["10.0.0.0/8"]
#   }
# }
# # output "rds_arn" {
# #   value = "${module.db.rds_arn}"
# # }

