resource "aws_security_group" "allow_elk4" {
  name        = "allow_elk4"
  description = "All all elasticsearch traffic"

  #vpc_id = "${aws_vpc.main.id}"

  # elasticsearch port
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # logstash port
  ingress {
    from_port   = 5043
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # kibana ports
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "elk" {
  ami           = "ami-5e8bb23b"
  instance_type = "t2.medium"
  key_name      = var.key
  vpc_security_group_ids = [
    aws_security_group.allow_elk4.id,
  ]

  provisioner "file" {
    content     = "network.bind_host: 0.0.0.0"
    destination = "/tmp/elasticsearch.yml"

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "file" {
    content     = "server.host: 0.0.0.0"
    destination = "/tmp/kibana.yml"

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "file" {
    content     = "http.host: 0.0.0.0"
    destination = "/tmp/logstash.yml"

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "file" {
    source      = "filebeat.yml"
    destination = "/tmp/filebeat.yml"

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "file" {
    source      = "beats.conf"
    destination = "/tmp/beats.conf"

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  provisioner "remote-exec" {
    script = "elasticsearch.sh"

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.private_key
    }
  }

  depends_on = [aws_security_group.allow_elk4]
}

resource "aws_eip" "ip" {
  instance = aws_instance.elk.id
}

