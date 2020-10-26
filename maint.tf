resource "aws_kms_key" "codeartifact_domain" {
  description = "domain key"
}
resource "aws_codeartifact_domain" "codeartifact_domain" {
  domain         = "${var.name_prefix}-codeartifact-${var.env}"
  encryption_key = aws_kms_key.codeartifact_domain.arn
}

resource "aws_codeartifact_domain_permissions_policy" "test" {
  domain          = aws_codeartifact_domain.codeartifact_domain.domain
  policy_document = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "codeartifact:CreateRepository",
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "${aws_codeartifact_domain.codeartifact_domain.arn}"
        }
    ]
}
EOF
}

resource "aws_codeartifact_repository" "codeartifact_repo" {
  repository = "${var.name_prefix}_repo"
  domain     = aws_codeartifact_domain.codeartifact_domain.domain
}

resource "aws_codeartifact_repository_permissions_policy" "example" {
  repository      = aws_codeartifact_repository.codeartifact_repo.repository
  domain          = aws_codeartifact_domain.codeartifact_domain.domain
  policy_document = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "codeartifact:CreateRepository",
            "Effect": "Allow",
            "Principal": "*",
            "Resource": "${aws_codeartifact_domain.codeartifact_domain.arn}"
        }
    ]
}
EOF
}