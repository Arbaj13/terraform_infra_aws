resource "aws_instance" "jenkins" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.medium"
  key_name      = "awsdec"
  user_data     = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install openjdk-11-jdk -y
                sudo apt install maven -y
                curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
                /usr/share/keyrings/jenkins-keyring.asc > /dev/null
                echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null
                sudo apt-get update
                sudo apt-get install jenkins -y
                ###
                EOF
  tags = {
    Name = "Jenkins Server"
  }
  vpc_security_group_ids = ["sg-081c6225252d4728d"]

}
