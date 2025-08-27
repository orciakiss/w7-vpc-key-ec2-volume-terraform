terraform {
  backend "s3" {
    bucket       = "ok-w7-terraformstatebucket" # replace with your bucket
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = false
  }
}