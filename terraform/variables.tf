variable "AWS_REGION" {
  default = "us-east-1"

}
variable AMIS {
  type = map
  default = {
    us-east-2  = "ami-07efac79022b86107"
    us-east-1  = "ami-0149b2da6ceec4bb0"
    ap-south-1 = "ami-009110a2bf8d7dd0a"
  }
}

variable "MYIP" {
  default = "0.0.0.0/0"

}
variable "vpcCIDR" {
  default = "172.21.0.0/16"

}
variable "instance_count" {
  default = "1"
  
}
variable "pubkey" {
  default = "cicd.pub"

}
variable "private_key" {
    default = "cicd"
  
}
variable "vpc_name" {
  default = "cicd-VPC"

}
variable "zone1" {
  default = "us-east-1a"

}
variable "zone2" {
  default = "us-east-1b"

}
variable "zone3" {
  default = "us-east-1c"

}

variable "pubsub1" {
  default = "172.21.1.0/24"

}
variable "pubsub2" {
  default = "172.21.2.0/24"

}
variable "pubsub3" {
  default = "172.21.3.0/24"

}
variable "prisub1" {
  default = "172.21.4.0/24"

}
variable "prisub2" {
  default = "172.21.5.0/24"

}
variable "prisub3" {
  default = "172.21.6.0/24"

}


