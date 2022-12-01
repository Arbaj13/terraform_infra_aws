resource "aws_instance" "nexus" {
  ami                    = "ami-02b972fec07f1e659"
  instance_type          = "t2.medium"
  key_name               = "awsdec"
  vpc_security_group_ids = ["sg-076688bb2766bfacc"]
  user_data              = file("/Users/arbaj/Desktop/aws_cicd/userdata/nexus3.sh")
  tags = {
    Name = "Nexus Server"

  }
}