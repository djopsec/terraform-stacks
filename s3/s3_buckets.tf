/* resource "aws_s3_bucket" "s3" {
  for_each = var.s3_list
  bucket   = each.key
  tags     = local.tags
}

resource "aws_s3_bucket_public_access_block" "s3" {
  for_each = aws_s3_bucket.s3
  bucket   = aws_s3_bucket.s3["${each.key}"].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
 */