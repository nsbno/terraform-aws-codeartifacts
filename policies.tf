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
      type        = "*"
      identifiers = ["*"]
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
      type        = "*"
      identifiers = ["*"]
    }
    resources = [aws_codeartifact_domain.codeartifact_domain.arn]
  }
}