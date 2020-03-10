FROM alpine:3.10

RUN apk add --no-cache bash curl jq go

ADD entrypoint.sh /entrypoint.sh
ADD src /src

RUN GO111MODULE=on go get github.com/mikefarah/yq/v3

ENTRYPOINT ["/entrypoint.sh"]
