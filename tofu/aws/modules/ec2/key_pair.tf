resource "aws_key_pair" "machine_ssh" {
  key_name   = "${var.project_name}-key-pair"
  public_key = file("~/.ssh/api_id_rsa.pub")
  tags       = var.tags
}