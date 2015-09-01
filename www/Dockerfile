FROM fedora:22

RUN dnf install -y  glibc-devel glibc-headers glibc-static\
                    gcc gcc-c++ cpp pcre-devel\
                    openssl-devel zlib-devel\
                    git mercurial\
                    tar wget\
                    cmake make autoconf pkgconfig\
                    libtool nasm which\
                    freetype*

# Download nginx
WORKDIR /opt/vendor
RUN wget http://nginx.org/download/nginx-1.9.4.tar.gz
RUN tar -xvpzf nginx-1.9.4.tar.gz

# Install nginx
WORKDIR /opt/vendor/nginx-1.9.4
RUN ./configure --with-http_spdy_module --with-http_ssl_module\
  --with-http_addition_module --with-http_sub_module\
  --with-http_auth_request_module\
  --with-http_secure_link_module --with-http_gzip_static_module\
  --with-http_gunzip_module --with-mail --with-mail_ssl_module\
  --with-http_flv_module --with-http_mp4_module
RUN make install
WORKDIR /opt

EXPOSE 80
EXPOSE 443
EXPOSE 8080

CMD /usr/local/nginx/sbin/nginx

ADD ./src/conf/nginx.conf /usr/local/nginx/conf/nginx.conf
ADD ./src/conf/www.conf /usr/local/nginx/conf/sites-enabled/www.conf
ADD ./src/html /opt/www/html
