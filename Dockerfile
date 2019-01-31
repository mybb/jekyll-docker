FROM starefossen/github-pages:onbuild

RUN apk update \
    && apk add openssl

CMD openssl req \
    -x509 \
    -subj "/C=NL/ST=Amsterdam/L=Amsterdam/O=localhost" \
    -nodes \
    -days 3650 \
    -newkey rsa:2048 \
    -keyout key_private.key \
    -out key_public.pem \
    && jekyll serve -d /_site --watch --force_polling --ssl-cert key_public.pem --ssl-key key_private.key -H 0.0.0.0 -P 4000
