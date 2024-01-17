resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "www.astro.com"
  type = "A"
  ttl = 300
  records = [aws_eip.lb.public_ip]
}

resource "aws_route53_record" "www_dev" {
  zone_id = aws_route53_zone.primary.zone_id
  name = "www"
  type = "CNAME"
  ttl = 5 

  weighted_route_policy {
    weight = 10
}

set_identifier = "dev"
records = ["dev.example.com"]

resource "aws_alb" "main" {
  name = "astro_terraform_alb"
  availability_zones = ["us-west-1a"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
   }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "astro.com"
  type    = "A"

  alias {
    name                   = aws_alb.main.dns_name
    zone_id                = aws_alb.main.zone_id
    evaluate_target_health = true
  }
}


