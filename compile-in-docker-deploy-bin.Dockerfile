## Multistage build
## Go progam will be build in golang image
## later binary will be deployed to minimal image with just binary and supporting files

# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang as builder

# as our code it in sub folder and it need files folder from there
# so command must be executed within that folder otherwise
# it will not be able to find files folder
#  set workdir to that folder, so all commands will be executed from that WORKDIR 
WORKDIR /go/src/samtech/fileserver

# Copy the local package files to the container's WORKDIR.
COPY . ./

# Build app inside the container.
RUN CGO_ENABLED=0 GOOS=linux go build -o fserver -a -installsuffix .




## Minimal linux image : alpine
FROM alpine:latest
WORKDIR /app/
COPY --from=builder /go/src/samtech/fileserver/fserver /app/fserver
COPY ./files/ /app/files/

# Run command where container starts
ENTRYPOINT /app/fserver

# Expose port 8080 that the service listens on
EXPOSE 8080
