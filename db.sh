#!/bin/bash

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-13
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo -i
su - postgres -c "createuser -s odoo"
su - postgres -c "createdb odoo"
sudo -u postgres psql -c "ALTER USER odoo WITH SUPERUSER;"