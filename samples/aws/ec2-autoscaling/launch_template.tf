locals {
  default_launch_template_name = local.default_component_name
  default_launch_template_instance_type = "t3.micro"
  default_launch_tempalte_user_data_filename = "${path.module}/launch_template_user_data.sh"
}

resource "aws_launch_template" "default" {
  name = local.default_launch_template_name
  image_id = local.default_ami_id
  instance_type = local.default_launch_template_instance_type
  key_name = local.default_key_name
  vpc_security_group_ids = [ local.default_security_group_id ]
  user_data = filebase64(local.default_launch_tempalte_user_data_filename)

  tags = {
    Name = local.default_launch_template_name
  }

  update_default_version = true

  instance_market_options {
    market_type = "spot"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = local.default_launch_template_name
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = local.default_launch_template_name
    }
  }
}

locals {
  default_launch_template_id = aws_launch_template.default.id
}
