variable "vpc_cidr" {
  description = "The cidr range for the VPC"
  type        = string
}

variable "subnet_vpc" {
  description = "The subnet CIDR range for the instance"
  type        = string 

}

variable "subnet_name" {
  description = "name of the subnet"
  type        = string


}
variable "region" {
  description = "The region you want to create the VPC"
  type        = string

}
