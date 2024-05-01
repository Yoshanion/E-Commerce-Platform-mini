resource "aws_s3_bucket" "ecommerce_assets" {
    bucket = "${var.backet_name}-${var.environmet}"
    acl    = "private"
    
    versioning {
        enabled = true
    }

    lifecycle_rule {
        id     = "log"
        enable = true

        prefix = "logs/"

        transition {
            days          = 30
            storage_class = "STANDARD_IA" 
        }

        expiration {
            days = 365
        }
    }

    tags = {
        Environment = var.environment
    }
}