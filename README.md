# dockerfiles


**Docker build**
```
docker build -t aws:latest -f aws.Dockerfile .
```
```
docker build -t terraform:1.3.9 -f terraform.Dockerfile .
```

**Alias**

```
alias aws='docker run --rm -v `PWD`:/app -it aws:latest'
alias terraform='docker run -it -v `PWD`:/app --rm terraform:1.3.9'
```

