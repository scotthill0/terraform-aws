variable "name" {
  description = "Name of the repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
  type        = string
  validation {
    condition = (
      var.image_tag_mutability == "MUTABLE" ||
      var.image_tag_mutability == "IMMUTABLE"
    )
    error_message = "Must be one of: MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "The encryption type to use for the repository. Valid values are AES256 or KMS."
  type        = string
  validation {
    condition = (
      var.encryption_type == "AES256" ||
      var.encryption_type == "KMS"
    )
    error_message = "Valid values are AES256 or KMS."
  }
  default = "AES256"
}

variable "kms_key" {
  description = "The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key for ECR."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(any)
  validation {
    condition = (
      try(length(lookup(var.tags, "Terraform")) > 0, false) &&
      try(length(lookup(var.tags, "Application")) > 0, false) &&
      try(length(lookup(var.tags, "Environment")) > 0, false)
    )

    error_message = "Not all obrigatory tags (CostCenter, OwnedBy, Terraform, Application, DeploymentID, Environment) are present, please review."
  }
}

variable "policy" {
  description = "JSON formatted string containing policies for the ECR repository."
  type        = any
  default     = null
}