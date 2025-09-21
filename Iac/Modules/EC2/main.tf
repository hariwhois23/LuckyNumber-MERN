resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "id_rsa.pub" //mention in string or it'll give you headaches
  vpc_security_group_ids      = [var.sg_id]
  subnet_id                   = var.subnet_id
  availability_zone           = data.aws_availability_zones.available.names[0]
  user_data_replace_on_change = true

  // optional to get the URL ip
  metadata_options {
    http_tokens   = "required" # Enforces IMDSv2
    http_endpoint = "enabled"  # Ensures metadata service is available
  }

  #bash script installs docker, git and docker-compose
  user_data = <<EOF
#!/bin/bash
sudo -i

# Update packages
apt-get update -y
apt-get upgrade -y

# Install Git
apt-get install -y git

# Install prerequisites for Docker
apt-get install -y apt-transport-https ca-certificates curl software-properties-common lsb-release gnupg

# Add Docker GPG key
mkdir -p /usr/share/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    > /etc/apt/sources.list.d/docker.list

# Update package index again
apt-get update -y

# Install Docker
apt-get install -y docker-ce docker-ce-cli containerd.io

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Install latest Docker Compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Log installed versions
docker --version > /home/ubuntu/install-log.txt 2>&1
docker-compose --version >> /home/ubuntu/install-log.txt 2>&1
git --version >> /home/ubuntu/install-log.txt 2>&1

echo "User data script completed." >> /home/ubuntu/install-log.txt

EOF

  tags = {
    Name = var.EC2_name
  }
}

// ssh-keygen -t rsa -b 2048 (2048 BITS) 
resource "aws_key_pair" "public-key" {
  key_name   = "id_rsa.pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCVl+nrJMB1akmcmyA+nhVZ7YiIjAcaRd/Gx78h7Rttv2ahxrhXTR68MjxKLPZGEDFyp0MPXpj4uz4NfjoXdvRBNks3U0fvdbByy4/tDuQrLW9sHRY+WK5xZR4fznQmQS5+Koej9D1jW1Lky7mulx1JOcU+kckLFqoRgGT71htOdG/kiqxab9rDONjuK36j9gIA8tFlM8DkhG4bUy98ZZBtScuXp+K/PTecgrkJ5Zgn47PDEYljRtZLMoatwfb06xKQgy8OM3w4j5LXgb9jMn61s3O8I47NdvH5RpzefPghrrL/uzXnj9N+0peF+qa2u52kM2E3mmYFIxznc23Jwo71 hariprasath@haris-MacBook-Air.local"

}
