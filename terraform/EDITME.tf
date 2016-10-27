provider "aws" {
   region = "eu-west-1"
   #maybe
   # access_key = "anaccesskey" (if you want to hardcode keys)
   # secret_key = "asecretkey"
   #or
   # shared_credentials_file  = "/Users/tf_user/.aws/creds"
   # profile                  = "customprofile"
}

variable "aws_region" {
  description = "The AWS region to work in."
  default = "eu-west-1"
}

variable "ami" {
    #default = "ami-f9dd458a"
    default =  "ami-2be8da5c"
}

variable "key_name" {
    description = " ssh access key name "
    default = "cloudera_training"
}

variable "local_key_file" {
    description = " local ssh file "
    default = "cloudera_training.key"
}

variable "my_rootdir" {
    description = "My homedir for logs and ssh key stuff. The '.ssh' directory will be here."
    default = "/Users/james.liu"
}

variable "whitelisted_source" {
   description = "this is the public address of your PC"
   default = "62.253.83.190/32"
}
