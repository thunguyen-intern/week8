FROM ubuntu:20.04

# Set environment variables
ENV ODOO_VERSION 15.0
ENV ODOO_USER odoo
ENV DEBIAN_FRONTEND noninteractive

# Install required packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends npm curl ca-certificates python3 python3-pip python3-dev libxml2-dev libpq-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential git libssl-dev libffi-dev libjpeg-dev libblas-dev libatlas-base-dev wkhtmltopdf nodejs npm sudo wget gnupg2 \
    && apt-get install -yq lsb-release \
    && curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
    && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
    && apt-get install -yq postgresql-client \
    && npm install -g less less-plugin-clean-css

RUN useradd -m -d /opt/odoo -U -r -s /bin/bash ${ODOO_USER} \
    && git clone https://www.github.com/odoo/odoo --depth 1 --branch ${ODOO_VERSION} /opt/odoo/odoo \
    && pip install --upgrade pip \
    && pip install wheel setuptools \
    && pip install -r /opt/odoo/odoo/requirements.txt

ADD /odoo/odoo.conf /etc/
ADD wait-for-psql.py /usr/local/bin/

EXPOSE 8069 8071 8072  

USER ${ODOO_USER}
WORKDIR /opt/odoo/odoo

ENTRYPOINT [ "/opt/odoo/odoo/odoo-bin" ]
CMD ["-c","/etc/odoo.conf"]