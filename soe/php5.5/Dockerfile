# Standard Operating Environment running off PHP 5.5.
FROM sitback/php:5.5

# Install all packages.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install socat ssmtp php5-xdebug

# Configure socat.
ADD ./conf/socat/start.sh /root/socat-start.sh
RUN chmod +x /root/socat-start.sh

# @TODO: Fix to be .docker.
# *.dev certificates
RUN mkdir /root/certs
COPY ./conf/certs/dev-self-signed-ssl.crt /root/certs/dev-self-signed-ssl.crt
COPY ./conf/certs/dev-self-signed-ssl.key /root/certs/dev-self-signed-ssl.key
COPY ./conf/apache2/ssl-vhost.conf /etc/apache2/sites-available/ssl.conf
RUN a2ensite ssl

# Configure PHP.
ADD ./conf/php/30-overrides.ini /etc/php5/apache2/conf.d/30-overrides.ini

# Setup Xdebug.
ADD ./conf/php/30-xdebug-conf.ini /etc/php5/apache2/conf.d/30-xdebug-conf.ini

# Install PimpMyLog.
RUN mkdir -p /server/pimpmylog && \
  composer require -d /server/pimpmylog "potsky/pimp-my-log" && \
  chmod -R 777 /server/pimpmylog/vendor/potsky/pimp-my-log
ADD ./conf/pimpmylog/config.user.json /server/pimpmylog/config.user.json
ADD ./conf/apache2/pimpmylog.conf /etc/apache2/sites-available/pimpmylog.conf
RUN a2ensite pimpmylog

# Add apache user to the adm group so they can read logs.
RUN usermod -a -G adm www-data

# Install MailHog & MailHog's sendmail replacement.
RUN curl -s -L https://github.com/mailhog/MailHog/releases/latest | egrep -o '/mailhog/MailHog/releases/download/[v.0-9]*/MailHog_linux_amd64' | wget --base=http://github.com/ -i - -O /usr/local/bin/mailhog
RUN chmod +x /usr/local/bin/mailhog
# Disabled until https://github.com/mailhog/mhsendmail/issues/3 is fixed.
# RUN curl -s -L https://github.com/mailhog/mhsendmail/releases/latest | egrep -o '/mailhog/mhsendmail/releases/download/[v.0-9]*/mhsendmail_linux_amd64' | wget --base=http://github.com/ -i - -O /usr/local/bin/mhsendmail
# RUN chmod +x /usr/local/bin/mhsendmail
# RUN update-alternatives --install /usr/sbin/sendmail mhsendmail /usr/local/bin/mhsendmail 1
# Configure PHP to use mhsendmail.
# ADD ./conf/php/40-mhsendmail.ini /etc/php5/cli/conf.d/40-mhsendmail.ini
# ADD ./conf/php/40-mhsendmail.ini /etc/php5/apache2/conf.d/40-mhsendmail.ini

# Configure SSMTP to relay to MailHog.
ADD ./conf/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf

# Startup settings.
ADD ./conf/supervisor/soe.conf /etc/supervisor/conf.d/soe.conf

# HTTP, HTTPS, MailHog SMTP, MailHog WebUI, PimpMyLog & Xdebug.
EXPOSE 80 443 1025 8000 8025 9000

WORKDIR /var/www

CMD ["/usr/bin/supervisord", "-n"]
