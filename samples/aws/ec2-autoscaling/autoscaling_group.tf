locals {
  default_autoscaling_group_name = local.default_component_name
}

resource "aws_autoscaling_group" "default" {
  name = local.default_autoscaling_group_name
  min_size = 1
  max_size = 1
  desired_capacity = 1
  vpc_zone_identifier = local.public_subnet_ids

  launch_template {
    id = local.default_launch_template_id
  }
}

locals {
  default_autoscaling_group_id = aws_autoscaling_group.default.id
}
