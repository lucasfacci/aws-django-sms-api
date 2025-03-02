resource "aws_instance" "machine" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"

  associate_public_ip_address = true
  key_name                    = aws_key_pair.machine_ssh.id
  vpc_security_group_ids      = [aws_security_group.machine_sg.id]
  user_data                   = file("../scripts/user_data.sh")

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-ec2"
    }
  )
}
