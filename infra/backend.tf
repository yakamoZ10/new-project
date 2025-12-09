terraform {
  backend "s3" {
    bucket         = "my-tf-backend-dev1"
    key            = "state/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "my-tf-locks-dev1"
    encrypt        = true
  }
}
