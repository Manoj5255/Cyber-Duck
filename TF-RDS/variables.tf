variable "aws_region" {
  type    = string
  default = "us-east-1" 
}

variable "db_username" {
  type    = string
  default = "root"  # Add the user name
}

variable "db_password" {
  type    = string
  default = "password"  # Set database password
}
