data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "qa_app" {
  name               = "${var.project_name}-app-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Environment = "QA"
    Purpose     = "kea-qa-app-execution-role"
  }
}

data "aws_iam_policy_document" "qa_app_permissions" {
  statement {
    sid     = "ReadAppSecretsFromSSM"
    actions = ["ssm:GetParameter", "ssm:GetParameters", "ssm:GetParametersByPath"]

    resources = [
      "arn:aws:ssm:${var.aws_region}:*:parameter/kea-qa/*"
    ]
  }
}

resource "aws_iam_role_policy" "qa_app_permissions" {
  name   = "${var.project_name}-app-ssm-read"
  role   = aws_iam_role.qa_app.id
  policy = data.aws_iam_policy_document.qa_app_permissions.json
}

resource "aws_iam_instance_profile" "qa_app" {
  name = "${var.project_name}-app-profile"
  role = aws_iam_role.qa_app.name
}


resource "aws_iam_role_policy_attachment" "ssm_core" {
  role = aws_iam_role.qa_app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


