resource "aws_s3_bucket" "s3web" {
  bucket_prefix = var.s3website

  tags = {
    Name = "Website bucket"
  }
}

resource "aws_s3_bucket_acl" "s3web" {
  bucket = aws_s3_bucket.s3web.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3web" {
  bucket = aws_s3_bucket.s3web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "s3webfiles" {
  for_each = module.template_files.files

  bucket       = aws_s3_bucket.s3web.id
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content

  etag = each.value.digests.md5
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.s3web.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.s3web.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}
