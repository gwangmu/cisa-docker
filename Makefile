all:
	@if id -aG ${USER} | grep -qw docker; then \
		echo "error: add this user to the 'docker' group first!"; \
		echo "error: 	# usermod -aG docker ${USER}"; \
	fi; \
	if docker images --format "{{.Repository}}:{{.Tag}}" | grep -qw "cisa:latest"; then \
		echo "info: already built."; \
		exit; \
	else \
		echo "info: building..."; \
	fi; \
	docker build -t cisa --build-arg USER_NAME=${USER} \
		--build-arg USER_UID=`id -u ${USER}` \
		--build-arg USER_GID=`id -g ${USER}` \
		--build-arg BUILD_TOOLS="${BUILD_TOOLS}" .
