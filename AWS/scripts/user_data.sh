#!/bin/bash
# host=$HOSTNAME
# sudo useradd uansible
# sudo usermod -p '$6$z/rg3opVFamXE.Kq$z/hGP2.38nbLDqfYKmCCbZvGkF7u9JLrhTvyrHAt2u1MGy1MbeJmoipYCbKApRZMWJ.EFSl9SzKkUsooP9lrM1' uansible
# sudo yum update -y
# sudo yum install -y aws-cli
# sudo amazon-linux-extras install nginx1
# sudo systemctl start nginx
# echo '<div style="text-align: center;"><img class="logo" src="https://www.vaggon.com.br/uploads/parceiro/250_02052019_211240.png"></div>' > index.html
# echo '<div style="text-align: center;"><img class="center" src="https://www.nozominetworks.com/wp-content/uploads/2021/08/telefonica-tech-logo.png"></div>' >> index.html
# echo '<h1><center>Virtual Machine generated with Terraform - Git - Atlantis</center></h1>' >> index.html
# echo '<h1><center>Telefonica Tech - CCoE - Arquitetura e Engenharia</center></h1>' >> index.html
# echo "<h1><center>Servidor: $host</center></h1>" >> index.html
# sudo mv index.html /usr/share/nginx/html/

#!/bin/bash
wget https://github.com/runatlantis/atlantis/releases/download/v0.19.3/atlantis_linux_amd64.zip
sudo apt -y install unzip
unzip atlantis_linux_amd64
sudo apt update
sudo apt -y install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt -y install ansible
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo apt install python3-pip
pip install boto3