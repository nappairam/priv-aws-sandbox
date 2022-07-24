data "aws_iam_policy_document" "allow_invoking_lambda_fn" {
  statement {
    actions = ["lambda:InvokeFunction"]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy" "step_fn_role_policy" {
  name   = "step_fn_role_policy"
  role   = aws_iam_role.step_fn_role.id
  policy = data.aws_iam_policy_document.allow_invoking_lambda_fn.json
}

data "aws_iam_policy_document" "step_fn_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["states.us-east-1.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "step_fn_role" {
  name               = "step_fn_role"
  assume_role_policy = data.aws_iam_policy_document.step_fn_assume_role_policy.json
}
