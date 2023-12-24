resource "aws_iam_role" "lambda_role" {
  name = "savana-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "role_role_attachment" {
  role = aws_iam_role.lambda_role.name
  count      = "${length(var.policy_arns)}"
  policy_arn = "${var.policy_arns[count.index]}"
}
