#!/bin/bash

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
sudo apt install -y postgresql-13
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo apt install -y node-less npm wkhtmltopdf python3-pip python-dev python3-dev libxml2-dev libpq-dev liblcms2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential git libssl-dev libffi-dev libjpeg-dev libblas-dev libatlas-base-dev
sudo npm install -g less less-plugin-clean-css

useradd -m -d /opt/odoo -U -r -s /bin/bash odoo
su - odoo
git clone https://www.github.com/odoo/odoo --depth 1 --branch 15.0 /opt/odoo/odoo
pip install --upgrade pip
pip install wheel setuptools
pip install -r /opt/odoo/odoo/requirements.txt

cd /var/log/
mkdir odoo
chown -R odoo: /var/log/odoo