resource "aws_ssm_parameter" "geoapify_key" {
  name        = "/kea-qa/NEXT_PUBLIC_GEOAPIFY_KEY"
  type        = "SecureString"
  value       = "placeholder-managed-outside-terraform"
  description = "Geoapify API key, used as a frontend build-arg in CI"

  lifecycle {
    ignore_changes = [value]
  }

  tags = {
    Environment = "QA"
    Purpose     = "github-actions-ci-cd"
  }
}

resource "aws_ssm_parameter" "tinymce_key" {
  name        = "/kea-qa/NEXT_PUBLIC_TINYMCE_API_KEY"
  type        = "SecureString"
  value       = "placeholder-managed-outside-terraform"
  description = "TinyMCE API key, used as a frontend build-arg in CI"

  lifecycle {
    ignore_changes = [value]
  }

  tags = {
    Environment = "QA"
    Purpose     = "github-actions-ci-cd"
  }
}

