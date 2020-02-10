provider "aws" {
  profile = "mine"
  region  = "ap-southeast-1"
  alias   = "main"
}

provider "aws" {
  profile = "mine"
  region  = "us-east-1"
  alias   = "cloudfront"
}

variable "fqdn" {
  description = "The fully-qualified domain name of the resulting S3 website."
  default     = "dabase.com"
}

variable "domain" {
  description = "The domain name."
  default     = "example.com"
}


# Using this module
module "main" {
  source = "github.com/riboseinc/terraform-aws-s3-cloudfront-website"

  fqdn                = "${var.fqdn}"
  ssl_certificate_arn = "${aws_acm_certificate_validation.cert.certificate_arn}"

  index_document = "index.html"
  error_document = "404.html"

  refer_secret = "${base64sha512("REFER-SECRET-19265125-${var.fqdn}-52865926")}"

  cloudfront_price_class = "PriceClass_All"

  force_destroy = "true"

  providers = {
    aws.main       = aws.main
    aws.cloudfront = aws.cloudfront
  }
}


# ACM Certificate generation

resource "aws_acm_certificate" "cert" {
  provider          = aws.cloudfront
  domain_name       = var.fqdn
  validation_method = "EMAIL"
}

resource "aws_acm_certificate_validation" "cert" {
  provider        = aws.cloudfront
  certificate_arn = aws_acm_certificate.cert.arn
}


# Outputs

output "s3_bucket_id" {
  value = "${module.main.s3_bucket_id}"
}

output "s3_bucket_arn" {
  value = "${module.main.s3_bucket_arn}"
}

output "s3_domain" {
  value = "${module.main.s3_website_endpoint}"
}

output "s3_hosted_zone_id" {
  value = "${module.main.s3_hosted_zone_id}"
}

output "cloudfront_domain" {
  value = "${module.main.cf_domain_name}"
}

output "cloudfront_hosted_zone_id" {
  value = "${module.main.cf_hosted_zone_id}"
}

output "cloudfront_distribution_id" {
  value = "${module.main.cf_distribution_id}"
}

output "acm_certificate_arn" {
  value = "${aws_acm_certificate_validation.cert.certificate_arn}"
}
