# Use RedHat UBI9 as base
FROM redhat/ubi9-minimal

ENV TERRAFORM_VERSION=1.4.2
ENV ANSIBLE_VERSION=4.10.0
ENV CDK_VERSION=2.68.0
ENV NODEJS_VERSION=18.x

# Install dependencies and update the package manager
RUN microdnf update -y && \
    microdnf install -y unzip less wget gzip tar python3-pip

# Download and install the AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip ./aws

# Install Node.js and npm
RUN microdnf install -y gcc-c++ make 
RUN curl -sL https://rpm.nodesource.com/setup_${NODEJS_VERSION} | bash - && \
    microdnf install -y nodejs

# Install CDK
RUN npm install -g aws-cdk@${CDK_VERSION}

# Install ansible
RUN pip3 install ansible==${ANSIBLE_VERSION}

RUN curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    terraform --version

# Install Terraform CDK
RUN npm install --global cdktf-cli@latest

# Add the AWS CLI to the system path
ENV PATH="/usr/local/bin:${PATH}"

# Set working directory
WORKDIR /app

# Map AWS credentials from the host machine into the container
VOLUME ~/.aws:/root/.aws

RUN microdnf clean all

RUN python3 --version
RUN aws --version
RUN cdk --version
RUN terraform --version
RUN ansible --version
RUN node --version

CMD ["tail", "-f", "/dev/null"]

