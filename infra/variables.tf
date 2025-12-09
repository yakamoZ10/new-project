variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "cpu" {
  type    = number
  default = 256
}

variable "memory" {
  type    = number
  default = 512
}

variable "account_id" {
  type = string
}

variable "github_repo" {
  type = string
  description = "Format: owner/repo (e.g., ardin123/nana-ecs-demo)"
}


variable "backend_bucket" {
  type = string
}

variable "backend_lock_table" {
  type = string
}
