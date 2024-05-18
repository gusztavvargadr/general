locals {
  iam_options = {
    name = local.deployment.name
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "default" {
  name               = local.iam_options.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Name = local.iam_options.name
  }
}

resource "aws_iam_instance_profile" "default" {
  name = local.iam_options.name
  role = aws_iam_role.default.name

  tags = {
    Name = local.iam_options.name
  }
}

locals {
  iam = {
    instance_profile_name = aws_iam_instance_profile.default.name
  }
}

output "iam" {
  value = local.iam
}
