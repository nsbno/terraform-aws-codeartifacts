# terraform-aws-codeArtifacts
A terraform module for AWS CodeArtifacts

Before you can connect to this repository, you must install the AWS CLI and configure your AWS credentials. AWS CodeArtifact is supported in these CLI versions:

1.18.83 or later. Install the AWS CLI version 1
2.0.54 or later. Install the AWS CLI version 2

Connection instruction for Gradle:

**Pulling from repo:**

1. Export a CodeArtifact authorization token for authorization to your repository from your preferred shell (token expires in 12 hours).
export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain $domain --domain-owner $account_id --query authorizationToken --output text`

2. Add this maven section to the repositories section in the project's build.gradle file
maven {
  url 'https://$domain-$account_id.d.codeartifact.$region.amazonaws.com/maven/$repo/'
  credentials {
      username "aws"
      password System.env.CODEARTIFACT_AUTH_TOKEN
  }
}

3. (Optional) Remove all other repositories in the repositories section. Gradle will exhaustively search for packages across each repository until a matching package is found.

**Pushing to repo:**

1. Export a CodeArtifact authorization token for authorization to your repository from your preferred shell (token expires in 12 hours).
export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain $domain --domain-owner $account_id --query authorizationToken --output text`

2. Add the maven-publish plugin to the plugins section of the project's build.gradle file.

plugins {
    id 'maven-publish'
}

3. Add a publishing section to the project's build.gradle file. Be sure to replace <groupId>, <artifactId>, <version> with the project's corresponding values.
publishing {
  publications {
      mavenJava(MavenPublication) {
          groupId = '<groupId>'
          artifactId = '<artifactId>'
          version = '<version>'
          from components.java
      }
  }
  repositories {
      maven {
          url 'https://$domain-$account_id.d.codeartifact.$region.amazonaws.com/maven/$repo/'
          credentials {
              username "aws"
              password System.env.CODEARTIFACT_AUTH_TOKEN
          }
      }
  }
}