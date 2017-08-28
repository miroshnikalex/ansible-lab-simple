variable "AWS_REGION" {
  default = "eu-central-1"
}
variable "AWS_AMI" {
  type = "map"
  default = {
    eu-central-1 = "ami-d74be5b8"
    eu-west-1    = "ami-ebd02392"
    eu-west-2    = "ami-a1f5e4c5"
    ca-central-1 = "ami-9062d0f4"
    us-east-1    = "ami-c998b6b2"
  }
}
variable "AVZ" {
  type = "map"
  default = {
    eu-central-1 = ["eu-central-1a","eu-central-1b","eu-central-1c"]
    eu-west-1    = ["eu-west-1a","eu-west-1b","eu-west-1c"]
    eu-west-2    = ["eu-west-2a","eu-west-2b"]
    ca-central-1 = ["ca-central-1a","ca-central-1b"]
    us-east-1    = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d","us-east-1e","us-east-1f"]
  }
}
variable "AWS_COUNT_WEB" {
  default = "1"
}
variable "AWS_COUNT_LB" {
  default = "1"
}
variable "AWS_COUNT_DB" {
  default = "1"
}
variable "AWS_KEY_NAME" {}
variable "AWS_INSTANCE_TYPE" {
  default = "t2.micro"
}
variable "AWS_PROFILE_NAME" {}
