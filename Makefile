test:
	$(MAKE) build || $(MAKE) cleanup

build:
	docker run -d --name configurationtest --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v $(shell pwd):/test/ jrei/systemd-ubuntu:20.04
	docker exec -it configurationtest /test/test.sh

cleanup:
	docker rm -f configurationtest

