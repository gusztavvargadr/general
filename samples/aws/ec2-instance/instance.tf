locals {
  instance_options = var.instance
}

resource "aws_instance" "default" {
  launch_template {
    id = local.launch_template.id
  }

  subnet_id = local.vpc.public_subnet_ids[count.index % length(local.vpc.public_subnet_ids)]

  tags = {
    Name = local.deployment.name
  }

  lifecycle {
    ignore_changes = [
      user_data
    ]
  }

  count = local.instance_options.count
}

locals {
  instances = [for instance in aws_instance.default : {
    id         = instance.id
    name       = instance.tags.Name
    public_ip  = instance.public_ip
    private_ip = instance.private_ip
  }]
}
