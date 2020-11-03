# my notes

## opensuse setup

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

## upload

### upload left

~~~bash
cp build/left/zephyr/zmk.uf2 /run/media/$USER/NICENANO/
~~~

### upload right

~~~bash
cp build/right/zephyr/zmk.uf2 /run/media/$USER/NICENANO/
~~~