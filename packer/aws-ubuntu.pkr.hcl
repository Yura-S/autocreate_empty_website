packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "WebsiteAmi"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230325"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"

  tags = {
    name  = "WebSiteImage"
    owner = "yura"
  }

}

build {

  name = "my-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "echo Updating Packages",
      "sudo apt update"
    ]
  }

  provisioner "shell" {
    inline = ["sudo apt install -y nginx"]
  }

  provisioner "shell" {
    inline = ["sudo systemctl status nginx"]
  }
}
