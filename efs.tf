resource "aws_efs_file_system" "minecraft-data" {
  availability_zone_name = var.aws-availability-zone
  encrypted              = true
  performance_mode       = "generalPurpose"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  tags = {
    Name = "minecraft-data"
  }
}

resource "aws_efs_backup_policy" "minecraft-data-backup-policy" {
  file_system_id = aws_efs_file_system.minecraft-data.id

  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "minecraft-data-mount-target" {
  file_system_id = aws_efs_file_system.minecraft-data.id
  subnet_id      = aws_subnet.ecs-default.id
  security_groups = [
    aws_security_group.allow_nfs.id
  ]
}
