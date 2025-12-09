
# # ECR repository
# data "aws_iam_policy_document" "github_oidc_trust" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Federated"
#       identifiers = ["arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"]
#     }

#     actions = ["sts:AssumeRoleWithWebIdentity"]

#     condition {
#       test     = "StringEquals"
#       variable = "token.actions.githubusercontent.com:aud"
#       values   = ["sts.amazonaws.com"]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "token.actions.githubusercontent.com:sub"
#       values   = ["repo:${var.github_repo}:ref:refs/heads/main"]
#     }
#   }
# }

# resource "aws_iam_role" "github_deploy_role" {
#   name               = "github-ecs-deploy-role"
#   assume_role_policy = data.aws_iam_policy_document.github_oidc_trust.json
# }


# data "aws_iam_policy_document" "github_deploy_policy" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "ecr:GetAuthorizationToken",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:CompleteLayerUpload",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:InitiateLayerUpload",
#       "ecr:PutImage",
#       "ecr:UploadLayerPart",
#       "ecr:BatchGetImage"
#     ]
#     resources = ["*"]
#   }

#   statement {
#     effect = "Allow"
#     actions = [
#       "ecs:UpdateService",
#       "ecs:DescribeServices",
#       "ecs:DescribeTaskDefinition",
#       "ecs:RegisterTaskDefinition"
#     ]
#     resources = ["*"]
#   }
# }

# resource "aws_iam_role_policy" "github_deploy_policy_attach" {
#   role   = aws_iam_role.github_deploy_role.id
#   policy = data.aws_iam_policy_document.github_deploy_policy.json
# }



