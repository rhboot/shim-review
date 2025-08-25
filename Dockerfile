RUN echo 4
FROM docker://vathpela/shim-rhel-10-aa64-20250818-buildroot:latest

COPY rpmmacros /root/.rpmmacros
RUN wget https://pjones.fedorapeople.org/rhel-10-aa64-20250818/shim-unsigned-aarch64-16.1-1.el10.src.rpm
RUN rpm -ivh shim-unsigned-aarch64-16.1-1.el10.src.rpm
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-aarch64.spec
COPY shimaa64.efi /
RUN rpm2cpio /builddir/build/RPMS/aarch64/shim-unsigned-aarch64-16.1-1.el10.aarch64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/16.1-1.el10/*/shim*.efi
RUN hexdump -Cv ./usr/share/shim/16.1-1.el10/aa64/shimaa64.efi > built-aa64.hex
RUN hexdump -Cv /shimaa64.efi > orig-aa64.hex
RUN objdump -h /usr/share/shim/16.1-1.el10/aa64/shimaa64.efi
RUN diff -u orig-aa64.hex built-aa64.hex
RUN pesign -h -P -i /usr/share/shim/16.1-1.el10/aa64/shimaa64.efi
RUN pesign -h -P -i /shimaa64.efi
RUN sha256sum /usr/share/shim/16.1-1.el10/aa64/shimaa64.efi /shimaa64.efi
