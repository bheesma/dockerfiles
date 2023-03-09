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

**Alias**

```
alias aws='docker run --rm -v `PWD`:/app -it aws:latest'
alias terraform='docker run --rm -v `PWD`:/app -it terraform:1.3.9'
alias cdk='docker run --rm -v `PWD`:/app -it cdk:latest'
alias ansible='docker run --rm -v `PWD`:/app -it ansible:latest'
```

