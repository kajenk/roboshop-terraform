data "aws_ami" "centos" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}

data "aws_security_group" "allow-all" {
  name = "allow-all"
}

variable "instance_type" {
  default = "t3.micro"

}
variable "components" {
  default = ["frontend", "mongodb", "catalogue"]

}

variable "dnszone" {
  default = "Z03680352BDV8JQ0ARSB5"

}

resource "aws_instance" "instance" {
  for_each = toset(var.components)
  ami             = data.aws_ami.centos.image_id
  instance_type   = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = each.value
  }
}

resource "aws_route53_record" "frontend" {
  for_each = toset(var.components)
  zone_id = var.dnszone
  name    = "${each.value}-dev.netseclab.ca"
  type    = "A"
  ttl     = 30
  records = ["aws_instance.${each.value}.private_ip"]
  depends_on = [
    aws_instance.instance
  ]
}


# resource "aws_instance" "instance" {
#   count           = length(var.components)
#   ami             = data.aws_ami.centos.image_id
#   instance_type   = var.instance_type
#   vpc_security_group_ids = [data.aws_security_group.allow-all.id]

#   tags = {
#     Name = var.components[count.index]
#   }
# }
##
# resource "aws_instance" "frontend" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = t3.micro

#   tags = {
#     Name = "frontend"
#   }
# }

# resource "aws_route53_record" "frontend" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "frontend-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.frontend.private_ip]
# }

# #####
# ##
# resource "aws_instance" "mongodb" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = t3.micro

#   tags = {
#     Name = "mongodb"
#   }
# }

# resource "aws_route53_record" "mongodb" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "mongodb-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.mongodb.private_ip]
# }

#####
##
# resource "aws_instance" "catalogue" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = t3.micro

#   tags = {
#     Name = "catalogue"
#   }
# }

# resource "aws_route53_record" "catalogue" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "catalogue-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.catalogue.private_ip]
# }

# #####
# ##
# resource "aws_instance" "radis" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "radis"
#   }
# }

# resource "aws_route53_record" "radis" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "radis-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.radis.private_ip]
# }

# #####
# ##
# resource "aws_instance" "user" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "user"
#   }
# }

# resource "aws_route53_record" "user" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "user-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.user.private_ip]
# }

# #####
# ##
# resource "aws_instance" "cart" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "cart"
#   }
# }

# resource "aws_route53_record" "cart" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "cart-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.cart.private_ip]
# }

# #####
# ##
# resource "aws_instance" "mysql" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "mysql"
#   }
# }

# resource "aws_route53_record" "mysql" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "mysql-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.mysql.private_ip]
# }

# #####
# ##
# resource "aws_instance" "shipping" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "shipping"
#   }
# }

# resource "aws_route53_record" "shipping" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "shipping-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.shipping.private_ip]
# }

# #####
# ##
# resource "aws_instance" "rabbitmq" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "rabbitmq"
#   }
# }

# resource "aws_route53_record" "rabbitmq" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "rabbitmq-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.rabbitmq.private_ip]
# }

# #####
# ##
# resource "aws_instance" "payment" {
#   ami           = data.aws_ami.centos.image_id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "payment"
#   }
# }

# resource "aws_route53_record" "payment" {
#   zone_id = "Z03680352BDV8JQ0ARSB5"
#   name    = "payment-dev.netseclab.ca"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.payment.private_ip]
# }

# #####

