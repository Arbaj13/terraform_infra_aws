resource "aws_instance" "nexus" {
  ami                    = "ami-02b972fec07f1e659"
  instance_type          = "t2.medium"
  key_name               = "awsdec"
  vpc_security_group_ids = ["sg-0cf43f0b8cd6a038c"]
  user_data              = file("../userdata/nexus3.sh")
  tags = {
    Name = "Nexus Server"

  }
}