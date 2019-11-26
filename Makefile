build:
	CGO_ENABLED=0 GOOS=linux go build -o fserver -a -installsuffix .

clean:
	@rm fserver

deploy-compile:
	docker build -f compile-in-docker.Dockerfile -t fserver-compiled .

deploy-compile-bin:
	docker build -f compile-in-docker-deploy-bin.Dockerfile -t fserver-compiled-bin .

deploy-bin-only: build
	docker build -f precompiled-bin.Dockerfile -t fserver-bin-only .
	@rm fserver

deploy-bin-log: build
	docker build -f precompiled-with-logs.Dockerfile -t fserver-bin-log .
	@rm fserver


docker-build-all:
	docker build -f compile-in-docker.Dockerfile -t fserver-compiled .
	docker build -f compile-in-docker-deploy-bin.Dockerfile -t fserver-compiled-bin .
	docker build -f precompiled-bin.Dockerfile -t fserver-bin-only .
	docker build -f precompiled-with-logs.Dockerfile -t fserver-bin-log .

docker-run-all:
	docker run --publish 6060:8080 -d --rm --name fserver1 fserver-compiled
	docker run --publish 6161:8080 -d --rm --name fserver2 fserver-compiled-bin
	docker run --publish 6262:8080 -d --rm --name fserver3 fserver-bin-only
	@mkdir /tmp/container-logs || true
	docker run --publish 6363:8080 -d --rm --name fserver4 -v /tmp/container-logs:/app/logs fserver-bin-log

	

docker-kill-all:
	@docker kill fserver1 || true
	@docker kill fserver2 || true
	@docker kill fserver3 || true
	@docker kill fserver4 || true
	docker ps -l


# docker-publish-wait:
# 	# publish image and wait in shell
# 	docker run --publish 6262:8080 --rm --name fserver3 deploy-bin-only

# docker-shell:
# 	# publish image and exit from shell (run in background)
# 	docker exec -it fserver3 /bin/sh