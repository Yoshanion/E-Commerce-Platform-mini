variable "origin_bucket_name" {
  type        = string
  description = "The S3 bucket name that CloudFront will use as the origin"
}

variable "origin_path" {
  type        = string
  default     = ""
  description = "The path within the S3 bucket to use as the origin path"
}

variable "comment" {
  type        = string
  description = "The comment for the CloudFront distribution"
}

variable "price_class" {
  type        = string
  default     = "PriceClass_100"
  description = "The price class for the CloudFront distribution"
}

