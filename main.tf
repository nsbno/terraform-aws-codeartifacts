data "aws_caller_identity" "current" {}

locals {
  current_account_id = data.aws_caller_identity.current.account_id
}

resource "aws_kms_key" "codeartifact_domain" {
  description = "codeartifact domain key"
}
resource "aws_kms_alias" "a" {
  name          = "alias/codeartifact-domain"
  target_key_id = aws_kms_key.codeartifact_domain.key_id
}
resource "aws_codeartifact_domain" "codeartifact_domain" {
  domain         = "${var.name_prefix}-codeartifact"
  encryption_key = aws_kms_key.codeartifact_domain.arn
}

resource "aws_codeartifact_domain_permissions_policy" "domain_policy" {
  domain          = aws_codeartifact_domain.codeartifact_domain.domain
  policy_document = data.aws_iam_policy_document.codeartifacts_domain_policy.json
}

resource "aws_codeartifact_repository" "codeartifact_repo" {
  for_each = var.repos
  repository = "${each.key}"
  domain     = aws_codeartifact_domain.codeartifact_domain.domain
}

resource "aws_codeartifact_repository_permissions_policy" "repo_policy" {
  for_each = var.repos
  repository      = aws_codeartifact_repository.codeartifact_repo[each.key].repository
  domain          = aws_codeartifact_domain.codeartifact_domain.domain
  policy_document = data.aws_iam_policy_document.codeartifacts_repo_policy.json
}
