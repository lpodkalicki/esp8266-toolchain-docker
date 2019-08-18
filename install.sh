#!/bin/bash

NAME=esp8266-toolchain
IMAGE_NAME=lpodkalicki/${NAME}
TOOLCHAIN_SCRIPT=${NAME}

docker pull ${IMAGE_NAME}:latest

cat <<EOF > /tmp/${TOOLCHAIN_SCRIPT}.tmp
#!/bin/bash

docker run --rm -it --privileged -v \$(pwd):/build ${IMAGE_NAME} "\$@"
EOF

chmod ugo+x /tmp/${TOOLCHAIN_SCRIPT}.tmp
sudo mv /tmp/${TOOLCHAIN_SCRIPT}.tmp /usr/bin/${TOOLCHAIN_SCRIPT}
