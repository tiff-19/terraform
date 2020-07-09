resource "aws_key_pair" "mykey" {
  key_name = "key-terraform"
  public_key = file(var.PATH_TO_PUBLIC_KEY)  
}

resource "aws_instance" "web-server1" {
  ami           = "ami-063e3af9d2cc7fe94"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.allow_ssh_mysql.name]
  tags = {
    Name = "Ubuntu-server"	
  }
  
  provisioner "file" {
    source = "script-ubuntu.sh"
    destination = "/tmp/script-ubuntu.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script-ubuntu.sh",
      "sudo /tmp/script-ubuntu.sh",
    ]
  
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.UBUNTU_INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}

resource "aws_instance" "web-server2" {
  ami           = "ami-02b6d9703a69265e9"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name
  security_groups = [aws_security_group.allow_ssh_mysql.name]
  tags = {
    Name = "RedHat-server"	
  }
  
  provisioner "file" {
    source = "script-redhat.sh"
    destination = "/tmp/script-redhat.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script-redhat.sh",
      "sudo /tmp/script-redhat.sh",
    ]
  
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.REDHAT_INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}

 output "ip_ubuntu" {
   value = aws_instance.web-server1.public_ip
 } 

 output  "dns_ubuntu" {
   value = aws_instance.web-server1.public_dns
 }

 output "ip_redhat" {
   value = aws_instance.web-server2.public_ip
 } 

 output  "dns_redhat" {
   value = aws_instance.web-server2.public_dns
 }