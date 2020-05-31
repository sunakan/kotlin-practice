DOCKER_GRADLE_TAG := 6.4-jdk14

pull:
	docker pull gradle:${DOCKER_GRADLE_TAG}

bash:
	$(eval WORKDIR := $(shell docker run --rm --tty --entrypoint=pwd gradle:${DOCKER_GRADLE_TAG}))
	docker run \
		--rm \
		--interactive \
		--tty \
		--name gradle \
		--hostname gradle \
		--user `id -u`:`id -g` \
		--workdir ${WORKDIR}/app/ \
		--mount type=bind,source=${PWD}/app/,target=${WORKDIR}/app/ \
		gradle:${DOCKER_GRADLE_TAG} bash
