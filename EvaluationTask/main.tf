# main.tf

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAZQ3DOZETOMPMC3UH"
  secret_key = "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"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-keyY"
  public_key = file("~/.ssh/id_ed25519.pub") # Path to your public SSH key
}
