# Module Elastic Container Registry

 Terraform module that creates a Elastic Container Registry to store container images on AWS.

 ECR features supported:

 - ECR policy creation
 - ECR image tag mutability

## Usage Examples

### Creating a ECR Repository with a policy

This example shows how to create an ECR repository adding an ECR policy to restricting repository access. Also, in this case, the image tag repository is immutable not allowing the tags to be changed.


```bash
module "ecr_with_policy" {
  source               = "../../"
  name                 = "ecr-repo"
  image_tag_mutability = "IMMUTABLE"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "testpolicy",
        Effect = "Allow",
        Principal = {
          "AWS" : "arn:aws:iam::accout:root"
        },
        Action = [
          "ecr:Get*"
        ]
      }
    ]
  })

  tags = {
    Environment  = "Dev"
    Terraform    = true
    Application  = "App"
  }
}
```

### Creating a ECR Repository using the AWS default KMS key

This example shows how to create an ECR repository using the AWS default managed KMS key for ECR. Also, in this case, the image tag repository is mutable allowing the tags to be changed.

```bash
module "ecr" {
  source               = "../../"
  name                 = "ecr-repo"
  image_tag_mutability = "MUTABLE"
  encryption_type      = "KMS"

  tags = {
    Environment  = "Dev"
    Terraform    = true
    Application  = "App"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the repository. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(any)` | n/a | yes |
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | The encryption type to use for the repository. Valid values are AES256 or KMS. | `string` | `"AES256"` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | The ARN of the KMS key to use when encryption\_type is KMS. If not specified, uses the default AWS managed key for ECR. | `string` | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | JSON formatted string containing policies for the ECR repository. | `any` | `null` | no |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false). | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_registry_id"></a> [registry\_id](#output\_registry\_id) | The registry ID where the repository was created. |
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | The Repository ARN. |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The URL of the repository (in the form aws\_account\_id.dkr.ecr.region.amazonaws.com/repositoryName). |
<!-- END_TF_DOCS -->