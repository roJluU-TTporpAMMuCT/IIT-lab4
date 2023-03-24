terraform {
	cloud {
    	organization = "kpi-labs"

    	workspaces {
      	name = "gh-actions-lab6"
    	}

  }

}

provider "aws" {
  region  = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-05803413c51f242b7"
  instance_type = "t2.micro"
  key_name = "keyforlab4"
  vpc_security_group_ids = [aws_security_group.demo-sg.id]
  associate_public_ip_address = true

user_data = <<-EOL
  #!/bin/bash -xe
  sudo apt update
  sudo apt -y install docker.io
  sudo docker run -d --name docker_site -p 80:80 negro228/iit-lab4
  sudo docker run -d \
  --name watchtower \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower
  EOL

  tags = {
    Name = "Lab6App"
  }
}