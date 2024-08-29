FROM ghcr.io/flatcar/flatcar-sdk-all:4054.0.0

# Clone the scripts repo
ARG REPO_URL=https://github.com/flatcar/scripts.git
WORKDIR /mnt/host/source/src/scripts/
RUN git clone $REPO_URL .

COPY --chown=sdk:sdk . /mnt/host/source/src/scripts

# Disable all sandboxing for SDK updates since some core packages
#  (like GO) fail to build from a permission error otherwise.
RUN echo 'export FEATURES="-sandbox -usersandbox -ipc-sandbox -network-sandbox -pid-sandbox"' \
        >> /home/sdk/.bashrc

RUN chown sdk:sdk /mnt/host/source
RUN ln -s /mnt/host/source/src/scripts/sdk_container/src/third_party /mnt/host/source/src/
RUN emerge-amd64-usr --nodeps shim

WORKDIR /shim-review
RUN sha256sum /build/amd64-usr/usr/lib/shim/shim.efi > SHAshimx86_64
RUN hexdump -Cv /build/amd64-usr/usr/lib/shim/shim.efi > build
