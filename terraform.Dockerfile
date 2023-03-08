# Use an official lightweight Alpine image as a parent image
FROM alpine:latest

# Set Terraform version
ARG TERRAFORM_VERSION=1.3.9

# Install required packages
RUN apk update && \
    apk upgrade && \
    apk add --no-cache curl unzip && \
    rm -rf /var/cache/apk/*

# Download and install Terraform
RUN curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Set working directory
WORKDIR /app

# Map AWS credentials from the host machine into the container
VOLUME ~/.aws:/root/.aws

ENTRYPOINT ["terraform"]

