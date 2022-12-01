resource "aws_instance" "jenkins" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.medium"
  key_name      = "awsdec"
  user_data     = file("../userdata/jenkins.sh")
  tags = {
    Name = "Jenkins Server"
  }
  vpc_security_group_ids = ["sg-081c6225252d4728d"]

}
