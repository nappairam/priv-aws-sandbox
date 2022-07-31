data "aws_iam_policy_document" "allow_sns_ses_step_actions" {
  statement {
    sid = "1"
    actions = [
      "sns:*",
      "ses:*",
      "states:*"
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "2"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name   = "lambda_role_policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.allow_sns_ses_step_actions.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
