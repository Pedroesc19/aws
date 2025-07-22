## Bucket
resource "aws_s3_bucket" "app_code" {
  bucket = var.app_bucket_name
  tags   = { Name = "store-app-code" }
}

## Objeto ZIP (usa el archivo que ya hiciste)
resource "aws_s3_object" "app_zip" {
  bucket       = aws_s3_bucket.app_code.id
  key          = var.app_zip_key
  source       = "${path.module}/app.zip"     # ⚠️ ruta local al ZIP
  etag         = filemd5("${path.module}/app.zip")
  content_type = "application/zip"
}
