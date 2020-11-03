data "aws_caller_identity" "current" {}

locals {
  current_account_id = data.aws_caller_identity.current.account_id
}

resource "aws_kms_key" "codeartifact_domain" {
  description = "domain key"
}
resource "aws_codeartifact_domain" "codeartifact_domain" {
  domain         = "${var.name_prefix}-${var.env}-codeartifact"
  encryption_key = aws_kms_key.codeartifact_domain.arn
}

resource "aws_codeartifact_domain_permissions_policy" "domain_policy" {
  domain          = aws_codeartifact_domain.codeartifact_domain.domain
  policy_document = data.aws_iam_policy_document.codeartifacts_domain_policy.json
}

resource "aws_codeartifact_repository" "codeartifact_repo" {
  repository = "${var.name_prefix}-repo"
  domain     = aws_codeartifact_domain.codeartifact_domain.domain
}

resource "aws_codeartifact_repository_permissions_policy" "repo_policy" {
  repository      = aws_codeartifact_repository.codeartifact_repo.repository
  domain          = aws_codeartifact_domain.codeartifact_domain.domain
  policy_document = data.aws_iam_policy_document.codeartifacts_repo_policy.json
}