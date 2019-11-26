## It will deploy precompiled binary to docer image
## will have minimam memory footprint

## Minimal linux image : alpine
FROM alpine
WORKDIR /app
COPY ./fserver ./
COPY ./files/ ./files/

# Run command where container starts
ENTRYPOINT ./fserver

# Expose port 8080 that the service listens on
EXPOSE 8080
