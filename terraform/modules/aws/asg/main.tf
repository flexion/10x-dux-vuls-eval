module "asg" {
  source = "git::https://github.com/cloudposse/terraform-aws-ec2-autoscale-group.git?ref=tags/0.4.0"

  namespace = var.namespace
  stage     = var.stage
  name      = var.name

  image_id                               = var.image_id
  instance_type                          = var.instance_type
  block_device_mappings                  = var.block_device_mappings
  key_name                               = var.key_name
  security_group_ids                     = var.security_group_ids
  subnet_ids                             = var.subnet_ids
  iam_instance_profile_name              = var.iam_instance_profile_name
  health_check_type                      = var.health_check_type
  min_size                               = var.min_size
  max_size                               = var.max_size
  wait_for_capacity_timeout              = var.wait_for_capacity_timeout
  associate_public_ip_address            = var.associate_public_ip_address
  user_data_base64                       = var.user_data_base64
  autoscaling_policies_enabled           = var.autoscaling_policies_enabled
  cpu_utilization_high_threshold_percent = var.cpu_utilization_high_threshold_percent
  cpu_utilization_low_threshold_percent  = var.cpu_utilization_low_threshold_percent
  tags                                   = var.tags
}