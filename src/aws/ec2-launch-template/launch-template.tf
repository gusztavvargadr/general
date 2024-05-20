resource "aws_launch_template" "default" {
  name = local.deployment.name

  image_id = local.launch_template_options.ami_id

  instance_type = local.launch_template_options.instance_type
  instance_market_options {
    market_type = local.launch_template_options.instance_market_options
  }

  ebs_optimized = true
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_type = local.launch_template_options.volume_type
      volume_size = local.launch_template_options.volume_size
    }
  }

  vpc_security_group_ids = [local.security_group.id]
  iam_instance_profile {
    name = local.iam.instance_profile_name
  }

  key_name  = local.key_pair.name
  user_data = base64encode(local.launch_template_options.user_data)

  tag_specifications {
    resource_type = "instance"
    tags          = local.deployment.tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = local.deployment.tags
  }

  tag_specifications {
    resource_type = "network-interface"
    tags          = local.deployment.tags
  }

  tag_specifications {
    resource_type = "spot-instances-request"
    tags          = local.deployment.tags
  }
}

locals {
  launch_template = {
    id   = aws_launch_template.default.id
    name = aws_launch_template.default.name
  }
}

output "launch_template" {
  value = local.launch_template
}
