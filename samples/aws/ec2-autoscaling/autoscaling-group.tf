resource "aws_autoscaling_group" "default" {
  name = local.deployment.name

  launch_template {
    id = local.launch_template.id
  }

  vpc_zone_identifier = local.vpc.public_subnet_ids

  min_size = 1
  max_size = 1
  desired_capacity = 1

  dynamic "tag" {
    for_each = local.deployment.tags
    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = false
    }
  }
}

locals {
  autoscaling_group = {
    id = aws_autoscaling_group.default.id
    name = aws_autoscaling_group.default.name
  }
}

output "autoscaling_group" {
  value = local.autoscaling_group
}
