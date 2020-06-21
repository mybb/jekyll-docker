FROM starefossen/github-pages:latest

RUN apk update \
    && apk add openssl

RUN gem install jekyll-local-theme

CMD openssl req \
        -x509 \
        -subj "/C=NL/ST=Amsterdam/L=Amsterdam/O=localhost" \
        -nodes \
        -days 3650 \
        -newkey rsa:2048 \
        -keyout key_private.key \
        -out key_public.pem \
    && jekyll serve \
        --destination /_site \
        --host 0.0.0.0 \
        --port 4000 \
        --watch \
        --force_polling \
        --ssl-cert key_public.pem \
        --ssl-key key_private.key \
        --config _config.yml,_config-dev.yml
