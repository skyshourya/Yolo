variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "aws_zone" {
  type    = string
  default = "us-east-1a"

}
variable "instance_type" {
  type    = string
  default = "t2.small"

}
variable "key_name" {
  type    = string
  default = "jazz"

}