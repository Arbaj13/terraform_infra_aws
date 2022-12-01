resource "aws_key_pair" "key" {
  key_name   = "cicd"
  public_key = file(var.pubkey)

}