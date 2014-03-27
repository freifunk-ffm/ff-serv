# some needed tools

```
apt-get install vim
apt-get install telnet
```

# Ruby Version 1.9.1, Rails version 4.0.3

https://library.linode.com/frameworks/ruby-on-rails-apache/debian-7-wheezy

```
apt-get install build-essential libapache2-mod-passenger apache2 ruby rdoc ruby-dev libopenssl-ruby rubygems
gem install fastthread
gem install rails (--version 4.0.3)
```

add path to /root/.bashrc

```
apt-get install libdbd-pg-ruby libpgsql-ruby libpq-dev
```

#gem install activerecord-postgresql-adapter

Adopt settings in config/database.yml

```
/srv/www/register.ffm.freifunk.net/ff-serv
bundle install
rake db:setup RAILS_ENV=production
```

```
#/srv/www/register.ffm.freifunk.net/ff-serv/config/environments/production.rb
#config.assets.compile = true
RAILS_ENV=production rake assets:precompile
```

# Apache

https://library.linode.com/web-servers/apache/installation/debian-6-squeeze

```
a2dissite default
service apache2 reload

vim /etc/apache2/sites-available/register.ffm.freifunk.net

 <VirtualHost *:80>
      ServerAdmin info@wifi-frankfurt.de
      ServerName register.ffm.freifunk.net
      ServerAlias register.ffm.freifunk.net
      DocumentRoot /srv/www/register.ffm.freifunk.net/ff-serv/public
      <Directory /srv/www/register.ffm.freifunk.net/ff-serv/public>
          Allow from all
          Options -MultiViews
      </Directory>
      ErrorLog /srv/www/register.ffm.freifunk.net/logs/error.log
      CustomLog /srv/www/register.ffm.freifunk.net/logs/access.log combined
 </VirtualHost>
```

# FF-Serv (Freifunk Registration Server)

```
mkdir -p /srv/www/register.ffm.freifunk.net/logs
cd /srv/www/register.ffm.freifunk.net

git clone https://github.com/freifunk-ffm/ff-serv.git
cd ff-serv
git checkout ffm

a2ensite register.ffm.freifunk.net
servivce apache2 reload

chmod 0666 /srv/www/register.ffm.freifunk.net/ff-serv/log/*
```

# DB einrichten

https://wiki.debian.org/PostgreSql

```
# su - postgres
$ psql

CREATE USER ffserv WITH PASSWORD 'averysecretpassword';
CREATE DATABASE ffserv OWNER ffserv;
\q

apt-get install vim

vim /etc/postgresql/9.1/main/postgresql.conf
listen_addresses = 'x.x.x.x'

vim /etc/postgresql/9.1/main/pg_hba.conf
# remote connection for specific databases (added by triplem)
host    ffserv          ffserv          x.x.x.0/24         md5
```

# Sync git repository

```
git remote add upstream https://help.github.com/articles/syncing-a-fork
git fetch upstream
git checkout v2
git merge upstream/v2

--> git checkout ffm
--> git merge v2
```

```
Server:
mv config/database.yml /root
git pull
mv /root/database.yml config
rake db:migrate RAILS_ENV=production
service apache2 restart
```
