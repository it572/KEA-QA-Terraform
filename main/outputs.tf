output "instance_id" {
  description =  "EC2  instance ID of the QA server"
  value = aws_instance.qa.id
}

output "public_ip" {
  description = "Public IP of the QA server"
  value = aws_instance.qa.public_ip
}

output "ssm_connect_command" {
  description = "Command to open a shell on the QA server via SSM (no SSH needed)"
  value = "aws ssm start-session --target ${aws_instance.qa.id} --region ${var.aws_region}"
}

output "security_group_id" {
  description = "Security group ID attached to the QA server"
  value = aws_security_group.qa_app.id
}

output "github_actions_role_arn" {
  description = "IAM role ARN for GitHub Actions to assume via OIDC"
  value = aws_iam_role.github_actions.arn
}

output "ecr_backend_repository_url" {
  description =  "ECR repository URL for backend images"
  value = aws_ecr_repository.backend.repository_url
}

output "ecr_frontend_repository_url" {
  description = "ECR repository URL for frontend images"
  value = aws_ecr_repository.frontend.repository_url
}


