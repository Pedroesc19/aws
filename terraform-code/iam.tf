data "aws_iam_policy_document" "s3_read" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.app_code.arn}/*"]
    effect    = "Allow"
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "store-web-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "s3_access" {
  name   = "s3-read-app-code"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.s3_read.json
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "store-web-instance-profile"
  role = aws_iam_role.ec2_role.name
}
