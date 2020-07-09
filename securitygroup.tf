resource "aws_security_group" "allow_ssh_mysql"{
    name        = "secgroupterraform"
    description = "Allow traffic ssh and mysql"
    vpc_id      = "vpc-34475d53"

    ingress {
        description = "allow ssh"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

        ingress {
        description = "allow mysql"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]  
    }
}