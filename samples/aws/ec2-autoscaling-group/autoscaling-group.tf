locals {
  autoscaling_group_options = {
    count = var.instances
  }
}

resource "aws_autoscaling_group" "default" {
  name = local.deployment.name

  launch_template {
    id = local.launch_template.id
  }

  vpc_zone_identifier = local.vpc.public_subnet_ids

  min_size         = local.autoscaling_group_options.count
  max_size         = local.autoscaling_group_options.count
  desired_capacity = local.autoscaling_group_options.count

  tag {
    key                 = "Name"
    value               = local.deployment.name
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = local.aws.tags
    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = false
    }
  }
}

locals {
  autoscaling_group = {
    id   = aws_autoscaling_group.default.id
    name = aws_autoscaling_group.default.name
  }
}
