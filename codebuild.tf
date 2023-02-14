resource "aws_iam_role" "codebuild_game_iam_role" {
  name = "codebuild_game_iam_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_game_iam_role_policy" {
  name = "codebuild_game_iam_role_policy"
  role = aws_iam_role.codebuild_game_iam_role.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": "*",
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents"
      ]
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "game_codebuild_project" {
  name          = "game_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_game_iam_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = "true"

    environment_variable {
      name  = "IMAGE_TAG"
      value = var.image_tag
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "DOCKER_HUB_USERNAME"
      value = var.docker_hub_username
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "DOCKER_HUB_PASSWORD"
      value = var.docker_hub_password
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "DOCKER_HUB_REPO_NAME"
      value = var.docker_hub_repo_name
      type  = "PLAINTEXT"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.github_location
    git_clone_depth = 1
  }
}

resource "aws_codebuild_webhook" "game_webhook" {
  project_name = aws_codebuild_project.game_codebuild_project.name
  build_type   = "BUILD"
  filter_group {
    filter {
      pattern = "PUSH"
      type    = "EVENT"
    }
  }
}