data "aws_ami" "centos" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]  
}
resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = "t3.micro"

  tags = {
    Name = "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z03680352BDV8JQ0ARSB5"
  name    = "frontend-dev.netseclab.ca"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}