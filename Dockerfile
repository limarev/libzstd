FROM ubuntu:latest


ARG android_sdk=/opt/android_sdk
ARG cmdline_tools_path=$android_sdk/cmdline-tools/latest
ENV PATH="${PATH}:$cmdline_tools_path/bin:${android_sdk}/ndk-bundle/toolchains/llvm/prebuilt/linux-x86_64/bin"


RUN DEBIAN_FRONTEND=noninteractive apt-get update \
&& apt-get install -y \
--no-install-recommends \
--fix-missing \
git \
g++ \
make \
cmake \
libssl-dev \
curl \
unzip \
default-jdk \
ca-certificates \
&& apt-get upgrade -y \
&& rm -rf /var/lib/apt/lists/* \
&& apt clean autoclean && apt autoremove -y

RUN curl https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -o cmdtools.zip \
&& unzip cmdtools.zip \
&& rm cmdtools.zip \
&& mkdir -p $cmdline_tools_path \
&& mv /cmdline-tools/* $cmdline_tools_path \
&& yes | sdkmanager --licenses \
&& sdkmanager --install "ndk-bundle" "platform-tools" "platforms;android-26" "build-tools;27.0.3" "extras;google;m2repository" "extras;android;m2repository"

WORKDIR /share
