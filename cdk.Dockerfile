FROM alpine:latest

RUN apk add --no-cache python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install awscli 

RUN apk add --no-cache nodejs npm && \
    npm install -g aws-cdk

ENTRYPOINT ["cdk"]

