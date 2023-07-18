variable "vpc_name" {
  description = "this is the VPC name"
  type = string
}

variable "vpc_cidr" {
    description = "CIDR block range of vpc"
}

variable "cidr_public" {
    description = "cidr of public"  
}

variable "cidr_private" {
    description = "cidr of private subnet"  
}

variable "cidr_data" {
    description = "cidr of data subnet"  
}
