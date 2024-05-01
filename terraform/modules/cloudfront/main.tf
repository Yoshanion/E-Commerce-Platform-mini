resource "aws_cloudfront_distribution" "ecommerce_cdn" {
    enabled = true
    comment = var.comment

    origin {
        domain_name = var.origin_bucket_name
        origin_id   = "S3-${var.origin_bucket_name}"

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.ecommerce_oai.path
        }
    }

    default_cache_behavior {
        target_origin_id       = "S3-${var.origin_bucket_name}"
        viewer_protocol_policy = "redirect-to-https"
        allowed_methods        = ["GET", "HEAD", "OPTIONS"]
        cached_methods         = ["GET", "HEAD"]

        forwarded_values {
            query_string = false 
            cookies {
                forward = "none"
            }
        }

        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }

    price_class = var.price_class

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}

resource "aws_cloudfront_origin_access_identity" "ecommerce_oai" {
  comment = "OAI for ${var.origin_bucket_name}"
}