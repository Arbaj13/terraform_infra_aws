resource "aws_instance" "sonarqube" {
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = "t2.medium"
  key_name               = "awsdec"
  vpc_security_group_ids = ["sg-076688bb2766bfacc"]
  user_data              = file("/Users/arbaj/Desktop/aws_cicd/userdata/sonarQube.sh")
  tags = {
    Name = "SonarQube Server"
  }
}