#!/usr/bin/env bash

# Set Testbed TSCH modules repository link

## Testbed Core modules

FIRMWARE_REPOSITORY="https://github.com/Kyoto-01/testbed-tsch-firmware.git"

SERIAL_READER_REPOSITORY="https://github.com/Kyoto-01/testbed-tsch-serial-reader.git"

RPC_CLIENT_REPOSITORY="https://github.com/Kyoto-01/testbed-tsch-rpc-client.git"

## Other modules

CONTROL_ENTITY_REPOSITORY="https://github.com/Kyoto-01/testbed-tsch-control-entity.git"

CONTROL_BRIDGE_REPOSITORY="https://github.com/Kyoto-01/testbed-tsch-control-bridge.git"

DATA_ANALYSIS_API_REPOSITORY="https://github.com/Kyoto-01/testbed-tsch-data-analysis-API.git"

BACKEND_WEB_REPOSITORY="https://github.com/Kyoto-01/testbed-tsch-web.git"

# Install dependencies

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
    build-essential \
    git \
    git-lfs \
    curl \
    wget \
    srecord \
    rlwrap \
    ca-certificates \
    gnupg

sudo apt install -y \
    python3-pip \
    python3-serial

python3 -m pip install virtualenv

## Install and setup ARM compiler dependency

mkdir ~/arm-compiler

cd ~/arm-compiler

wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2

tar -xjf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2

echo "if [ -d \"\$HOME/arm-compiler/gcc-arm-none-eabi-9-2020-q2-update/bin\" ] ; then \
PATH=\"\$HOME/arm-compiler/gcc-arm-none-eabi-9-2020-q2-update/bin:\$PATH\"; fi" >> ~/.profile

echo 'ATTRS{idVendor}=="0451", ATTRS{idProduct}=="16c8", ENV{ID_MM_DEVICE_IGNORE}="1"' | \
	sudo tee -a /lib/udev/rules.d/77-mm-usb-device-blacklist.rules > /dev/null

source ~/.profile

cd -

## Install Docker dependency

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-buildx-plugin \
	docker-compose-plugin

## Install Node.js dependency

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

source ~/.bashrc

nvm install node

## Install InfluxDB dependency

wget -q https://repos.influxdata.com/influxdata-archive_compat.key

echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | \
	sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | \
	sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null

echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | \
	sudo tee /etc/apt/sources.list.d/influxdata.list

sudo apt update && sudo apt install -y influxdb2

sudo systemctl start influxd

# Create testbed structure

mkdir ~/testbed-tsch

cd ~/testbed-tsch

git clone ${FIRMWARE_REPOSITORY}

git clone ${SERIAL_READER_REPOSITORY}

git clone ${RPC_CLIENT_REPOSITORY}

git clone ${CONTROL_ENTITY_REPOSITORY}

git clone ${CONTROL_BRIDGE_REPOSITORY}

git clone ${DATA_ANALYSIS_API_REPOSITORY}

git clone ${BACKEND_WEB_REPOSITORY}

# Create and setup Python 3 virtual environments

mkdir ~/venvs

cd ~/venvs

python3 -m virtualenv testbed-tsch-build-tool
source testbed-tsch-build-tool/bin/activate
python3 -m  pip install -r ~/testbed-tsch/testbed-tsch-firmware/tools/testbed-build/requirements.txt
deactivate

python3 -m virtualenv testbed-tsch-serial-reader
source testbed-tsch-serial-reader/bin/activate
python3 -m  pip install -r ~/testbed-tsch/testbed-tsch-serial-reader/requirements.txt
deactivate

python3 -m virtualenv testbed-tsch-rpc-client
source testbed-tsch-rpc-client/bin/activate
python3 -m  pip install -r ~/testbed-tsch/testbed-tsch-rpc-client/requirements.txt
deactivate

python3 -m virtualenv testbed-tsch-control-entity
source testbed-tsch-control-entity/bin/activate
python3 -m pip install -r ~/testbed-tsch/testbed-tsch-control-entity/requirements.txt
deactivate

python3 -m virtualenv testbed-tsch-control-bridge
source testbed-tsch-control-bridge/bin/activate
python3 -m pip install -r ~/testbed-tsch/testbed-tsch-control-bridge/requirements.txt
deactivate

python3 -m virtualenv testbed-tsch-data-analysis-api
source testbed-tsch-data-analysis-api/bin/activate
python3 -m pip install -r ~/testbed-tsch/testbed-tsch-data-analysis-API/requirements.txt
deactivate

cd -

