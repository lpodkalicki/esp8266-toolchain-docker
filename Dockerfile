FROM debian:jessie-slim

MAINTAINER Lukasz Marcin Podkalicki <lpodkalicki@gmail.com>

# Prepare directory for tools
ARG TOOLS_PATH=/tools
RUN mkdir ${TOOLS_PATH}
WORKDIR ${TOOLS_PATH}

# Install basic programs and custom glibc
RUN apt-get update && apt-get install -y \
	ca-certificates tar bzip2 wget make git gperf sed bash help2man libtool libtool-bin \
	autoconf automake libtool gcc g++ flex bison texinfo gawk ncurses-dev \
	libffi-dev libssl-dev python python-dev python-setuptools python-pip

# Install cmake 3.5
ARG CMAKE_VERSION=3.5
ARG CMAKE_BUILD=2
ARG CMAKE_PATH=${TOOLS_PATH}/cmake-${CMAKE_VERSION}.${CMAKE_BUILD}-Linux-x86_64
ARG CMAKE_INSTALLER_FILENAME=cmake-${CMAKE_VERSION}.${CMAKE_BUILD}-Linux-x86_64.sh
RUN wget https://cmake.org/files/v${CMAKE_VERSION}/${CMAKE_INSTALLER_FILENAME}
RUN chmod ugo+x ./${CMAKE_INSTALLER_FILENAME} \
	&&  echo "y" | ./${CMAKE_INSTALLER_FILENAME} --prefix=${TOOLS_PATH}

ENV PATH="${CMAKE_PATH}/bin:${PATH}"

# Install xtensa toolchain
ARG TOOLCHAIN_TARBALL_URL=https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-92-g8facf4c-5.2.0.tar.gz
ARG TOOLCHAIN_PATH=${TOOLS_PATH}/toolchain
RUN wget ${TOOLCHAIN_TARBALL_URL} \
	&& export TOOLCHAIN_TARBALL_FILENAME=$(basename "${TOOLCHAIN_TARBALL_URL}") \
	&& tar -xvf ${TOOLCHAIN_TARBALL_FILENAME}  \
	&& mv `tar -tf ${TOOLCHAIN_TARBALL_FILENAME} | head -1` ${TOOLCHAIN_PATH} \
	&& rm ${TOOLCHAIN_TARBALL_FILENAME}

ENV PATH="${TOOLCHAIN_PATH}/bin:${PATH}"

# Install RTOS SDK
ARG IDF_PATH=${TOOLS_PATH}/ESP8266_RTOS_SDK
RUN git clone https://github.com/espressif/ESP8266_RTOS_SDK.git \
	&& pip install --upgrade pip \
	&& pip install --upgrade setuptools \
	&& python -m pip install --user -r ${IDF_PATH}/requirements.txt

ENV IDF_PATH=${IDF_PATH}
ENV PWD=/build

# Change workdir
WORKDIR /build
