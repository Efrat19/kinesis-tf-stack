
variable "partition" {
  default = "default"
  description = "stream partition"
}



//aws_kinesis_stream variable
variable "shard_count" {
  description = "The number of shards that the stream will use."
  default     = "1"
}

variable "retention_period" {
  description = "Length of time data records are accessible after they are added to the stream."
  default     = "24"
}

variable "shard_level_metrics" {
  type        = "list"
  description = "A list of shard-level CloudWatch metrics which can be enabled for the stream."
  default     = [
    "IncomingBytes",
    "OutgoingBytes",
  ]
}

