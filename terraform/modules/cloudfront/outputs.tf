output "aws_cloudfront_distribution_id" {
    value = aws_cloudfront_distribution.ecommerce_cdn.id
}

output "aws_cloudfront_distribution_domain" {
    value = aws_cloudfront_distribution.ecommerce_cdn.domain_name
}