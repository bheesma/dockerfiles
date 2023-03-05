FROM alpine:latest

RUN apk update && \
    apk add --no-cache python3 && \
    apk add ansible

ENTRYPOINT ["ansible-playbook"]
