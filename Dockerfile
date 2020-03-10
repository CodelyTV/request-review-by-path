FROM alpine:3.10

RUN apk add --no-cache bash curl jq yq

ADD entrypoint.sh /entrypoint.sh
ADD src /src

ENTRYPOINT ["/entrypoint.sh"]
