data "aws_iam_policy_document" "codeartifacts_repo_policy" {
  statement {
    effect  = "Allow"
    actions = ["codeartifact:DescribePackageVersion",
                "codeartifact:DescribeRepository",
                "codeartifact:GetPackageVersionReadme",
                "codeartifact:GetRepositoryEndpoint",
                "codeartifact:ListPackageVersionAssets",
                "codeartifact:ListPackageVersionDependencies",
                "codeartifact:ListPackageVersions",
                "codeartifact:ListPackages",
                "codeartifact:PublishPackageVersion",
                "codeartifact:PutPackageMetadata",
                "codeartifact:ReadFromRepository"
                ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.current_account_id}:root"]
    }
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "codeartifacts_domain_policy" {
  statement {
    effect  = "Allow"
    actions =  ["codeartifact:CreateRepository",
                "codeartifact:DescribeDomain",
                "codeartifact:GetAuthorizationToken",
                "codeartifact:GetDomainPermissionsPolicy",
                "codeartifact:ListRepositoriesInDomain",
                "sts:GetServiceBearerToken"
                ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.current_account_id}:root"]
    }
    resources = ["*"]
  }
}