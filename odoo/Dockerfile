# The debian version to be used.
ARG OS_VERSION

FROM debian:${OS_VERSION}

MAINTAINER brainchild GmbH <docker@brain-child.de>

# The debian version to be used.
ARG OS_VERSION

# Build args. Maybe overwritten during build using --build-arg option.
# Enter the version number of odoo: http://nightly.odoo.com/<version>/nightly/deb/odoo_<version>.<release>_all.deb
ARG ODOO_VERSION=11.0

# Enter the release number of odoo: http://nightly.odoo.com/<version>/nightly/deb/odoo_<version>.<release>_all.deb
ARG ODOO_RELEASE=latest

# Enter the version number of wkhtmltox: http://nightly.odoo.com/extra/wkhtmltox-<version>_linux-${OS_VERSION}-amd64.deb
ARG WKHTMLTOX_VERSION=0.12.2.1

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
            node-less \
            python-gevent \
            python-pip \
            python-renderpm \
            python-support \
            python-watchdog \
            cython \
        && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-${WKHTMLTOX_VERSION}_linux-${OS_VERSION}-amd64.deb \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get -y install -f --no-install-recommends \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false npm \
        && rm -rf /var/lib/apt/lists/* wkhtmltox.deb \
        && pip install psycogreen==1.0 pgen pydevd

# Install Odoo
RUN set -x; \
        curl -o odoo.deb -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb \
        && dpkg --force-depends -i odoo.deb \
        && apt-get update \
        && apt-get -y install -f --no-install-recommends \
        && rm -rf /var/lib/apt/lists/* odoo.deb

# Copy entrypoint script and Odoo configuration file
COPY ./test-remote-debug.py /
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/

RUN id -u odoo &>/dev/null || useradd odoo

RUN chown odoo /etc/odoo/odoo.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
        && chown -R odoo /mnt/extra-addons

VOLUME ["/etc/odoo", "/var/lib/odoo", "/mnt/extra-addons", "/usr/lib/python2.7/dist-packages/odoo/addons"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
