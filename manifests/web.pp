exec { "apt-update":
  command => "/usr/bin/apt-get update"
}
package { ["php", "php-mcrypt", "php-mbstring", "php-curl", "php-mysql", "php-xml", "php-zip", "php-json", "nodejs", "git", "mysql-server"]:
  ensure => installed,
  require => Exec["apt-update"]
}


git clone https://2trues_victor:2terrier@gitlab.com/coblue/coblue-back.git
git clone https://2trues_victor:2terrier@gitlab.com/coblue/coblue-front.git

#instala e configura composer globalmente
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

#instala bower e gulp globalmente
npm install -g gulp bower

#---ALTERAR O DIRETORIO PARA A RAIZ DO BACKEND---
cd coblue-back
chmod 777 -R storage
chmod 777 -R bootstrap
composer install
php artisan passport:keys

#---ALTERAR O DIRETORIO PARA A PASTA master DO FRONTEND---
cd ../coblue-front/master
npm install
bower install
