terraform {
  backend "gcs" {
    bucket = "backend_terraform_805032"
    prefix = "terraform/state"
  }
}
