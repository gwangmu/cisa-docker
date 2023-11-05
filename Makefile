docker_perm_test=if id -aG ${USER} | grep -qw docker; then \
		echo "error: add this user to the 'docker' group first!"; \
		echo "error: 	\$ sudo usermod -aG docker ${USER}"; \
		exit; \
	fi;

cisa_image_test=`docker images --format "{{.Repository}}:{{.Tag}}" \
	| grep -qw "cisa:latest"`

all:
	@${docker_perm_test} \
	if [ -n ${cisa_image_test} ]; then \
		echo "info: already built."; \
		exit; \
	else \
		echo "info: building..."; \
	fi; \
	docker build -f Dockerfiles/all -t cisa:latest --label cisa \
		--build-arg USER_NAME=${USER} \
		--build-arg USER_UID=`id -u ${USER}` \
		--build-arg USER_GID=`id -g ${USER}` . 

up:
	@${docker_perm_test} \
	if [ ! -n ${cisa_image_test} ]; then \
		echo "error: please make an image first."; \
		exit; \
	else \
		echo "info: building incrementally..."; \
	fi; \
	if [ -f "${RECONF_PATH}" ]; then \
		cp ${RECONF_PATH} .proj.reconf; \
	fi; \
	docker build -f Dockerfiles/up -t cisa:latest --label cisa \
		--build-arg USER_NAME=${USER} \
		--build-arg BUILD_TOOLS="${BUILD_TOOLS}" .; \
	docker image prune --force --filter='label=cisa'; \
	rm -f .proj.reconf
