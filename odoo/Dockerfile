#The debian version to be used.
ARG OS_VERSION

FROM debian:${OS_VERSION}

MAINTAINER brainchild GmbH <docker@brain-child.de>

# Build args. Maybe overwritten during build using --build-arg option.
# Enter the version number of odoo: http://nightly.odoo.com/<version>/nightly/deb/odoo_<version>.<release>_all.deb
ARG ODOO_VERSION=12.0

# Enter the release number of odoo: http://nightly.odoo.com/<version>/nightly/deb/odoo_<version>.<release>_all.deb
ARG ODOO_RELEASE=latest

# Enter the version number of wkhtmltox: https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_${WKHTMLTOX_VERSION}-1.${OS_VERSION}_amd64.deb
ARG WKHTMLTOX_VERSION=0.12.5

# Set the Debian release again. Otherwise it does net get used in the next step.
ARG OS_VERSION

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
	    dirmngr \
            fonts-noto-cjk \
            gnupg \
            libssl1.0-dev \
            node-less \
            python3-pip \
            python3-pyldap \
            python3-qrcode \
            python3-renderpm \
            python3-setuptools \
            python3-vobject \
            python3-watchdog \
	    xz-utils \
            cython \
	    postgresql-client \
  && curl -o wkhtmltox.deb -sSL https://downloads.wkhtmltopdf.org/0.12/${WKHTMLTOX_VERSION}/wkhtmltox_${WKHTMLTOX_VERSION}-1.${OS_VERSION}_amd64.deb \
        && echo '1140b0ab02aa6e17346af2f14ed0de807376de475ba90e1db3975f112fbd20bb wkhtmltox.deb' | sha256sum -c - \
        && dpkg --force-depends -i wkhtmltox.deb\
        && apt-get -y install -f --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# Install rtlcss (on Debian stretch)
RUN set -x;\
    	echo "deb http://deb.nodesource.com/node_8.x stretch main" > /etc/apt/sources.list.d/nodesource.list \
    	&& export GNUPGHOME="$(mktemp -d)" \
    	&& repokey='9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280' \
    	&& gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${repokey}" \
    	&& gpg --armor --export "${repokey}" | apt-key add - \
    	&& gpgconf --kill all \
   	&& rm -rf "$GNUPGHOME" \
    	&& apt-get update \
    	&& apt-get install -y nodejs \
    	&& npm install -g rtlcss \
    	&& rm -rf /var/lib/apt/lists/*

# Install Odoo
RUN set -x; \
        curl -o odoo.deb -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb \
        && dpkg --force-depends -i odoo.deb \
        && apt-get update \
        && apt-get -y install -f --no-install-recommends \
        && rm -rf /var/lib/apt/lists/* odoo.deb \
	&& chown -R odoo /usr/lib/python3/dist-packages/odoo

# Copy entrypoint script and Odoo configuration file
RUN pip3 install num2words xlwt
COPY ./test-remote-debug.py /
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/

RUN set -x; \
       chmod +x /test-remote-debug.py \
    && chmod +x /entrypoint.sh \
    && chown odoo /etc/odoo/odoo.conf \
    && mkdir -p /mnt/extra-addons \
    && chown -R odoo /mnt/extra-addons

VOLUME ["/etc/odoo", "/var/lib/odoo", "/mnt/extra-addons", "/usr/lib/python3/dist-packages/odoo/addons"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
