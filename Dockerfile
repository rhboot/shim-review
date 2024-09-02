FROM ghcr.io/flatcar/flatcar-sdk-all:4054.0.0

ARG REPO_URL=https://github.com/flatcar/scripts.git
ARG WORK_DIR=/mnt/host/source/src/scripts

# Clone the scripts repo
WORKDIR /mnt/host/source/src/scripts/
RUN git clone $REPO_URL .
RUN git -C $WORK_DIR fetch --tags
RUN git -C $WORK_DIR checkout alpha-4054.0.0

COPY --chown=sdk:sdk . /mnt/host/source/src/scripts

RUN chown sdk:sdk /mnt/host/source
RUN ln -s /mnt/host/source/src/scripts/sdk_container/src/third_party /mnt/host/source/src/
ENV SOURCE_DATE_EPOCH=1
RUN emerge-amd64-usr --nodeps shim

WORKDIR /shim-review
RUN sha256sum /build/amd64-usr/usr/lib/shim/shim.efi | tee SHAshimx86_64
RUN hexdump -Cv /build/amd64-usr/usr/lib/shim/shim.efi > build
