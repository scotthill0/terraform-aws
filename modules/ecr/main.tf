resource "aws_ecr_repository" "repository" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.encryption_type == "AES256" ? null : var.kms_key
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "repository_policy" {
  count      = var.policy == null ? 0 : 1
  repository = aws_ecr_repository.repository.name

  policy = var.policy
}