# Overview

Lightweight docker image built on top of **debian:jessie-slim** with installed xtensa toolchain, ESP8266_RTOS_SDK and few additional tools:
* xtensa-lx106 (crosstool-NG crosstool-ng-1.22.0-92-g8facf4c; 5.2.0)
* ESP8266_RTOS_SDK (v3.2)
* esptool.py (v2.4)
* make (v4.2)
* cmake (v3.5)

DockerHub: https://hub.docker.com/r/lpodkalicki/esp8266-toolchain

## Building image locally

```bash
git clone https://github.com/lpodkalicki/esp8266-toolchain-docker.git
cd eps8266-toolchain
docker build --rm -t lpodkalicki/esp8266-toolchain:latest .
```

## An example of running toolchain binary

```bash
docker run --rm -it --privileged -v $(pwd):/build lpodkalicki/esp8266-toolchain xtensa-lx106-elf-gcc --version
```

# Installing

Bellow you can find recommended simple one-line installer that pulls the newest docker-image and installs **esp8266-toolchain** script into "/usr/bin/" directory.

```bash
curl https://raw.githubusercontent.com/lpodkalicki/esp8266-toolchain-docker/master/install.sh | bash -s --
```

## Getting started

1. Install toolchain using recommended simple one-line installer.
2. Use super command **esp8266-toolchain** for all toolchain binaries. 
3. Execute toolchain binaries inside your working/project directory. 

## Examples

```bash
$ cd your-project/
$ esp8266-toolchain idf.py build
$ esp8266-toolchain idf.py flash
$ esp8266-toolchain idf.py monitor
$ esp8266-toolchain xtensa-lx106-elf-gcc --version
$ esp8266-toolchain make -version
$ esp8266-toolchain cmake -version
$ esp8266-toolchain make menuconfig
$ esp8266-toolchain make && make flash monitor
```
