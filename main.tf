resource "random_string" "random_number" {
  length  = 4 # Specify the desired length of the hexadecimal string
  special = false
}

resource "aws_s3_bucket" "example" {
  count = length(var.s3_bucket_name)
  #bucket        = format("${var.s3_bucket_name}-%02d", count.index + 1)
  bucket        = var.s3_bucket_name[count.index]
  force_destroy = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


