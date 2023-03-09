# Use the official Amazon Linux 2 image as the base image
FROM amazonlinux:2

# Install dependencies and update the package manager
RUN yum update -y && \
    yum install -y unzip groff less && \
    yum clean all

# Install Node.js and npm
RUN curl -sL https://rpm.nodesource.com/setup_17.x | bash - && \
    yum install -y nodejs

# Download and install the AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip ./aws

RUN npm install -g aws-cdk@latest

# Add the AWS CLI to the system path
ENV PATH="/usr/local/bin:${PATH}"

# Set working directory
WORKDIR /app

# Map AWS credentials from the host machine into the container
VOLUME ~/.aws:/root/.aws

ENTRYPOINT ["cdk"]

