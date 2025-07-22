#########################
# Bucket y objeto  ZIP  #
#########################

# Bucket S3 para el código de la app
resource "aws_s3_bucket" "app_code" {
  bucket = (
    var.app_bucket_name != "" ?
    var.app_bucket_name :
    "store-app-code-bucket-${random_id.suffix.hex}"
  )

  tags = { Name = "store-app-code" }
}

# app.zip (se sube desde tu máquina/local runner)
resource "aws_s3_object" "app_zip" {
  bucket       = aws_s3_bucket.app_code.id
  key          = var.app_zip_key
  source       = "${path.module}/app.zip"
  etag         = filemd5("${path.module}/app.zip")
  content_type = "application/zip"
}

# Output para usarlo en workflows y secrets
output "app_bucket_name" {
  value = aws_s3_bucket.app_code.bucket
}
