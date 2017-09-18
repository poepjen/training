#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-958128fa
#
# Your subnet ID is:
#
#     subnet-6987b713
#
# Your security group ID is:
#
#     sg-73a74919
#
# Your Identity is:
#
#     terraform-training-yak
#
terraform {
   backend "atlas" {
      name = "poepjen/training"
   }
}


variable "aws_access_key" {
   type    = "string"
}

variable "aws_secret_key" {
   type    = "string"
}

variable "aws_region" {
   type = "string"
   default = "eu-central-1"
}
 
variable "aws_instance_numbers" {
   default = "2"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-958128fa"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-6987b713"
  vpc_security_group_ids = ["sg-73a74919"]
  count      = "${var.aws_instance_numbers}"
  tags {
    Identity = "terraform-training-yak"
    Creator  = "Jens"
    Owner    = "Jens"
    Name     = "web ${count.index+1}/${var.aws_instance_numbers}"

  }
}

output "public_ip" {
   value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
   value = "${aws_instance.web.*.public_dns}"
}
