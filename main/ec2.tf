data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "qa" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.qa_app.id]
  iam_instance_profile = aws_iam_instance_profile.qa_app.name
  
  root_block_device {
    volume_size = var.root_volume_size_gb
    volume_type = "gp3"
    encrypted = true
    delete_on_termination= true

    tags = {
      Name = "${var.project_name}-root-volume"
      Environment = "QA"
    }
  }
  
  user_data = <<-EOF
    #!/bin/bash
    set -e
    sed -i 's|http://|https://|g' /etc/apt/sources.list
    apt-get update -y
    apt-get install -y ca-certificates curl gnupg git unzip

    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update -y
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    usermod -aG docker ubuntu

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
    unzip -q /tmp/awscliv2.zip -d /tmp
    /tmp/aws/install
  EOF

  tags = {
    Name = "${var.project_name}-v5"
    Environment = "QA"
    Purpose  = "kea-erp-qa-app-server"
  }
}

