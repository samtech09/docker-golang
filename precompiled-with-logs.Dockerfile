## It will deploy precompiled binary to docer image
## will have minimam memory footprint

## Minimal linux image : alpine
FROM alpine
WORKDIR /app

# Build Args
ARG LOG_DIR=/app/logs

# Create Log Directory
RUN mkdir -p ${LOG_DIR}

# Environment Variables
ENV LOG_FILE_LOCATION=${LOG_DIR}/app.log 

COPY ./fserver ./
COPY ./files/ ./files/

# Run command where container starts
ENTRYPOINT ./fserver

# Expose port 8080 that the service listens on
EXPOSE 8080

# Declare volumes to mount
VOLUME [${LOG_DIR}]

