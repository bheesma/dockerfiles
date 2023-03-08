FROM alpine:latest

RUN apk add --no-cache python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install awscli 

# Map AWS credentials from the host machine into the container
VOLUME ~/.aws:/root/.aws

ENTRYPOINT ["aws"]

