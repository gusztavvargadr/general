resource "aws_instance" "default" {
  launch_template {
    id = local.launch_template.id
  }

  subnet_id = local.vpc.public_subnet_ids[0]
}

locals {
  instance = {
    id        = aws_instance.default.id
    name      = aws_instance.default.tags_all.Name
    public_ip = aws_instance.default.public_ip
    user      = local.ami_options.user
  }
}

output "instance" {
  value = local.instance
}
