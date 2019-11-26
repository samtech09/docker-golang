## Go progam will be build inside docker container
## Resulting image will be huge (>800MB)

# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

# Copy the local package files to the container's workspace.
ADD . /go/src/samtech/fileserver

# as our code it in sub folder and it need files folder from there
# so command must be executed within that folder otherwise
# it will not be able to find files folder
#  set workdir to that folder, so all commands will be executed from that WORKDIR 
WORKDIR /go/src/samtech/fileserver

# Build app inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
## RUN go install /go/src/samtech/go-docker
##RUN go build -o /go/src/samtech/go-docker/godocker /go/src/samtech/go-docker
##RUN go build -o /go/src/samtech/fileserver/fserver /go/src/samtech/fileserver
RUN go build -o fserver .

# Run command where container starts
ENTRYPOINT /go/src/samtech/fileserver/fserver

# Expose port 8080 that the service listens on
EXPOSE 8080
