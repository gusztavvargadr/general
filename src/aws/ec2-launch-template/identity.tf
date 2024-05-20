locals {
  key_pair_options = {
    name = local.deployment.name
    public = local.launch_template_options.public_key
  }
}

resource "aws_key_pair" "default" {
  key_name   = local.key_pair_options.name
  public_key = local.key_pair_options.public
}

locals {
  key_pair = {
    id = aws_key_pair.default.id
    name = aws_key_pair.default.key_name
  }
}

output "key_pair" {
  value = local.key_pair
}

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
}

resource "aws_iam_instance_profile" "default" {
  name = local.iam_options.name
  role = aws_iam_role.default.name
}

locals {
  iam = {
    role_id   = aws_iam_role.default.id
    role_name = aws_iam_role.default.name

    instance_profile_id   = aws_iam_instance_profile.default.id
    instance_profile_name = aws_iam_instance_profile.default.name
  }
}

output "iam" {
  value = local.iam
}
