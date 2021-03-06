# my notes

## setup

### setup opensuse

~~~bash
sudo zypper install -y \
    autoconf \
    automake \
    bzip2 \
    ccache \
    cmake \
    dtc \
    dfu-tool \
    git \
    gcc \
    gcc-c++ \
    libtool \
    make \
    ninja \
    wget \
    xz

    # python3-devel \
    # python3-pip \
    # python3-setuptools \
~~~

### setup native_posix

~~~bash
sudo zypper install gcc-32bit glibc-devel-32bit libgcc_s1-32bit
~~~

### setup bt

opensuse doesn't work out of the box for rpi bluetooth. need to be turned in to a service

~~~bash
sudo ln -sf /lib/firmware/*.hcd /lib/firmware/brcm/
sudo btattach -B /dev/ttyAMA1 --protocol bcm -S 3000000
~~~

## install

### install zephyr

~~~bash
export ZSDK_VERSION=0.11.2
wget -q "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZSDK_VERSION}/zephyr-toolchain-arm-${ZSDK_VERSION}-setup.run" && \
    sh "zephyr-toolchain-arm-${ZSDK_VERSION}-setup.run" --quiet -- -d ~/.local/zephyr-sdk-${ZSDK_VERSION} && \
    rm "zephyr-toolchain-arm-${ZSDK_VERSION}-setup.run"
~~~

## build

~~~bash
$MASK build left
$MASK build right
~~~

### build init

~~~bash
west init -l config
west update
west zephyr-export
~~~

### build left

~~~bash
time west build --pristine -s zmk/app -d build/left -b nice_nano -- -DSHIELD=lily58_left -DZMK_CONFIG=$PWD/config
~~~

### build right

~~~bash
time west build --pristine -s zmk/app -d build/right -b nice_nano -- -DSHIELD=lily58_right -DZMK_CONFIG=$PWD/config
~~~

### build native

~~~bash
time west build -s zmk/app -d build/native -b native_posix_64 -- -DSHIELD=zmk_linux -DZMK_CONFIG=$PWD/native_posix_config
~~~

## upload

### upload left

~~~bash
udisksctl mount -b /dev/sda
cp lily58_left_nice_nano.uf2 /run/media/$USER/NICENANO/
~~~

### upload right

~~~bash
udisksctl mount -b /dev/sda
cp lily58_right_nice_nano.uf2 /run/media/$USER/NICENANO/
~~~

## run

### run native

runs a native_posix build with bluetooth and flash, which is stored in flash.bin

~~~bash
sudo ./build/native/zephyr/zmk.elf --bt-dev=hci0
~~~
