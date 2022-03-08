VS_HOST ?= ""

image:
	@docker build -t looper .

check_vs_host:
	@test $${VS_HOST?VS_HOST environment variable is not set}

run:
	@docker run -d --name looper --ulimit memlock=-1 --shm-size=256M --ulimit rtprio=99 --cap-add SYS_NICE --network host looper

stop:
	@docker rm -f looper
