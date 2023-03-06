# Define instance variables
variable "instance_type" {
  default = "t2.micro" # Change this to your desired instance type
}

variable "ami" {
  default = "ami-0c55b159cbfafe1f0" # VyOS 1.3 AMI ID for us-east-1
}

variable "subnet_cidr_blocks" {
  default = ["10.0.1.0/24"] # Change these to your desired subnet CIDR blocks
}