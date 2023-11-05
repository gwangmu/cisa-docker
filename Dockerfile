FROM ubuntu:20.04

ARG USER_NAME
ARG USER_UID
ARG USER_GID

ENV CISA_ROOT /etc/cisa
ENV LLVM_URL https://github.com/llvm/llvm-project/releases/download/llvmorg-15.0.5/clang+llvm-15.0.5-x86_64-linux-gnu-ubuntu-18.04.tar.xz
ENV TZ "America/New_York"

# Set up user account.

RUN addgroup --gid ${USER_GID} ${USER_NAME}
RUN adduser --disabled-password --gecos '' \
  --uid ${USER_UID} --gid ${USER_GID} ${USER_NAME}

# Install dependencies.

RUN apt-get update && \
  apt-get install -y tzdata && \
  apt-get install -y git build-essential wget cmake && \
  apt-get install -y python3 python3-pip python-is-python3 && \
  pip install gitpython termcolor alive_progress

USER ${USER_NAME}
WORKDIR ${CISA_ROOT}

# Download LLVM and make.

RUN git clone https://github.com/gwangmu/cisa.git && cd cisa && \
  wget ${LLVM_URL} && mkdir llvm && \
  tar -xvf $(basename ${LLVM_URL}) -C llvm --strip-components 1 && \
  rm $(basename ${LLVM_URL}) && make
