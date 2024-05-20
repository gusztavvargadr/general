locals {
  security_group_options = {
    name   = local.deployment.name
    vpc_id = local.launch_template_options.vpc_id
  }
}

resource "aws_security_group" "default" {
  name   = local.security_group_options.name
  vpc_id = local.security_group_options.vpc_id
}

locals {
  security_group = {
    id = aws_security_group.default.id
    name = aws_security_group.default.name
  }
}

output "security_group" {
  value = local.security_group
}
