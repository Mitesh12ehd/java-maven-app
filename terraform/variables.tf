variable vpc_cidr_block {
    default = "10.0.0.0/16"
}
variable subnet_cidr_block {
    default = "10.0.10.0/24"
}
variable availability_zone {
    default = "ap-south-1b"
}
variable env_prefix {
    default = "dev"
}      
variable "instance_type" {
    default = "t3.micro"
}