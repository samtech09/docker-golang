# docker-golang
Self learning project to play will docker, deploying go code and binaries to docker

<br />

There are 4 docker files
```
compile-in-docker.Dockerfile
compile-in-docker-deploy-bin.Dockerfile
precompiled-bin.Dockerfile
precompiled-with-logs.Dockerfile
```

### compile-in-docker.Dockerfile
It deploys all go code to docker, compile then run binary. Docker image size is huge.


### compile-in-docker-deploy-bin.Dockerfile
It deployes go code to docker, build then create minimal image by copying binary from previous docker image. Resulting docker image is very low on size.


### precompiled-bin.Dockerfile
It deployes prebuild binary (build in host machine) to docker image. Docker image size very low.


### precompiled-with-logs.Dockerfile
Same as `precompiled-bin` but also attach volume to write logs by go apps. Logs are accessible from host machine.
