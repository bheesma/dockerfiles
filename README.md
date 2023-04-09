# dockerfiles


**Docker build**
```
docker build --pull -t aws:latest -f aws.Dockerfile .
```
```
docker build --pull -t terraform:1.3.9 -f terraform.Dockerfile .
```
```
docker build --pull -t cdk:latest -f cdk.Dockerfile .
```
```
docker build --pull -t ansible:latest -f ansible.Dockerfile .
```
```
docker build -t devops:latest -f devops.Dockerfile .
```

**Alias**

```
alias aws='docker run --rm -v ~/.aws:/root/.aws -v `PWD`:/app -it aws:latest'
alias terraform='docker run --rm -v ~/.aws:/root/.aws -v `PWD`:/app -it terraform:1.3.9'
alias cdk='docker run --rm -v ~/.aws:/root/.aws -v `PWD`:/app -it cdk:latest'
alias ansible='docker run --rm -v ~/.aws:/root/.aws -v `PWD`:/app -it ansible:latest'
```


**.zshrc entries - Shell Functions**

```
check_devops_container() {
    # Check if a container with the name "devops" is running
    if ! docker ps --format '{{.Names}}' | grep -q devops; then 
        # Check if a container with the name "devops" is stopped
        if docker ps -a --filter "name=devops" --filter "status=exited" | grep -q devops; then
            # Start the stopped devops container
            docker start devops >/dev/null
        else
            # Start the devops container
            docker run -d -v "$HOME"/.aws:/root/.aws -v "$(pwd)":/app  --name devops devops:latest >/dev/null
        fi
    fi

    cmd="docker exec -it devops $@"
    eval $cmd
}

aws() { check_devops_container "$0 $*" }
terraform() { check_devops_container "$0 $*" }
cdk() { check_devops_container "$0 $*" }
ansible() { check_devops_container "$0 $*" }
node() { check_devops_container "$0 $*" }
custodian() { check_devops_container "$0 $*" }
```