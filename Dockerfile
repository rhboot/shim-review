FROM debian:bullseye
RUN apt-get update -y
RUN echo "deb-src http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential git-buildpackage
RUN git clone https://github.com/ozun215/shim-review-1.git
WORKDIR /shim-review-1
RUN git checkout gooroom-3.0
WORKDIR /
RUN git clone https://github.com/gooroom/shim.git
WORKDIR /shim
RUN git checkout gooroom-3.0
RUN apt-get build-dep -y .
RUN gbp buildpackage -us -uc --git-ignore-branch
WORKDIR /
RUN hexdump -Cv /shim/shim*.efi > build
RUN hexdump -Cv /shim-review-1/$(basename /shim/shim*.efi) > orig
RUN diff -u orig build
RUN sha256sum /shim/shim*.efi /shim-review-1/$(basename /shim/shim*.efi)
