FROM alpine:3.10

RUN apk add --no-cache bash curl jq

ADD entrypoint.sh /entrypoint.sh
ADD src /src

RUN wget -O /usr/local/bin/yaml2json "https://github.com/bronze1man/yaml2json/releases/download/v1.3/yaml2json_linux_amd64"
RUN chmod +x /usr/local/bin/yaml2json

ENTRYPOINT ["/entrypoint.sh"]
