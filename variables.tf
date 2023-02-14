variable "access_key" {
  default   = ""
  sensitive = true
}

variable "secret_key" {
  default   = ""
  sensitive = true
}

variable "user_data_file_path" {
  default   = ""
  sensitive = true
}

variable "docker_hub_username" {
  default   = ""
  sensitive = true
}

variable "docker_hub_password" {
  default   = ""
  sensitive = true
}

variable "docker_hub_repo_name" {
  default   = ""
  sensitive = true
}

variable "github_location" {
  default = ""
}

variable "image_tag" {
  default   = ""
  sensitive = true
}