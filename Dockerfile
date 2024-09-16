FROM ghcr.io/flatcar/flatcar-sdk-all:4054.0.0

ARG SCRIPTS_REPO_URL=https://github.com/flatcar/scripts.git
ARG SCRIPTS_WORK_DIR=/mnt/host/source/src/scripts

ARG FLATCAR_TEST_CA_REPO_URL=https://github.com/jepio/flatcar-test-ca
ARG FLATCAR_TEST_CA_WORK_DIR=/mnt/host/source/src/flatcar-test-ca

# Alternative: We can directly wget the flatcar-ca.der file
WORKDIR /mnt/host/source/src/flatcar-test-ca
RUN git clone $FLATCAR_TEST_CA_REPO_URL .

# Clone the scripts repo
WORKDIR /mnt/host/source/src/scripts/
RUN git clone $SCRIPTS_REPO_URL .
RUN git -C $SCRIPTS_WORK_DIR fetch --tags
# RUN git -C $WORK_DIR checkout alpha-4054.0.0
RUN git -C $SCRIPTS_WORK_DIR checkout sayan/add-shim-signing

COPY --chown=sdk:sdk . /mnt/host/source/src/scripts

RUN chown sdk:sdk /mnt/host/source
RUN ln -s /mnt/host/source/src/scripts/sdk_container/src/third_party /mnt/host/source/src/
ENV SOURCE_DATE_EPOCH=1
ENV USE=official
ENV SHIM_SIGNING_CERTIFICATE=/mnt/host/source/src/flatcar-test-ca/flatcar-ca.der
RUN emerge-amd64-usr --nodeps shim

WORKDIR /shim-review
RUN sha256sum /build/amd64-usr/usr/lib/shim/shimx64.efi | tee shimx64-15.8.sha256
RUN cp /build/amd64-usr/usr/lib/shim/shimx64.efi shimx64-15.8.efi
RUN objcopy --only-section .sbat -O binary shimx64-15.8.efi /dev/stdout | tee sbat-shimx64-15.8.csv
RUN hexdump -Cv shimx64-15.8.efi > build
