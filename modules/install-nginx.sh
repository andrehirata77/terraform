#! /bin/bash
host=$HOSTNAME
sudo apt -y install nginx && sudo systemctl start nginx
echo '<img class="center" src="https://www.nozominetworks.com/wp-content/uploads/2021/08/telefonica-tech-logo.png">' > index.html
echo '<h1><center>Virtual Machine generated with Terraform - Git - Atlantis</center></h1>' >> index.html
echo '<h1><center>Telefonica Tech - CCoE - Arquitetura e Engenharia</center></h1>' >> index.html
echo "<h1><center>Servidor: $host</center></h1>" >> index.html
sudo mv index.html /var/www/html/