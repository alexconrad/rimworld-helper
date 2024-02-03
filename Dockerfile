FROM httpd:2.4

COPY ./server.crt /usr/local/apache2/conf/server.crt
COPY ./server.key /usr/local/apache2/conf/server.key

COPY ./app /usr/local/apache2/htdocs/

# Enable SSL module
RUN sed -i '/#LoadModule ssl_module/s/^#//g' /usr/local/apache2/conf/httpd.conf

# Configure SSL
RUN echo "Listen 443" >> /usr/local/apache2/conf/httpd.conf
RUN echo "ServerName rimworld.local:443" >> /usr/local/apache2/conf/httpd.conf
RUN echo "SSLCertificateFile /usr/local/apache2/conf/server.crt" >> /usr/local/apache2/conf/httpd.conf
RUN echo "SSLCertificateKeyFile /usr/local/apache2/conf/server.key" >> /usr/local/apache2/conf/httpd.conf

RUN echo "SSLProtocol all -SSLv2 -SSLv3" >> /usr/local/apache2/conf/httpd.conf

RUN echo "<VirtualHost *:443>" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    ServerName rimworld.local" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    DocumentRoot /usr/local/apache2/htdocs" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    SSLEngine on" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    SSLCertificateFile /usr/local/apache2/conf/server.crt" >> /usr/local/apache2/conf/httpd.conf
RUN echo "    SSLCertificateKeyFile /usr/local/apache2/conf/server.key" >> /usr/local/apache2/conf/httpd.conf
RUN echo "</VirtualHost>" >> /usr/local/apache2/conf/httpd.conf

