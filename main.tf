# main.tf

provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-keyY"
  public_key = file("~/.ssh/id_ed25519.pub") # Path to your public SSH key
}
