resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "raw_data" {
  bucket        = "raw-data-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name = "raw-data"
  }
}

resource "aws_s3_bucket" "processed_data" {
  bucket        = "processed-data-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name = "processed-data"
  }
}

