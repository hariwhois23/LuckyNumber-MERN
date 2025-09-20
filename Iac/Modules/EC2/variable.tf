variable "sg_id" {
  description = "The id of the security group"
  type        = string
}

variable "subnet_id" {
  description = "The subnet that has to be associated with"
  type        = string

}

variable "EC2_name" {
  description = "The name for the ec2 instances "
  type        = string
  default     = "Webserver1"

}