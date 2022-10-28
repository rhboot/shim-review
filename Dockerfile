FROM centos:8

RUN rpm -e centos-linux-repos --noscripts --nodeps
#RUN rm /etc/yum.repos.d/*.repo
COPY rpmmacros /root/.rpmmacros
COPY softwarecenter.repo /etc/yum.repos.d/
#RUN yum -y install wget
#RUN wget https://github.com/LiangJianNSDL/shim-review/blob/nsdl-v4-shim/shim-unsigned-x64-15.6-1.el8.src.rpm
COPY shim-unsigned-x64-15.6-1.el8.src.rpm ./
RUN rpm -e centos-linux-release --noscripts --nodeps
RUN yum -y install nde-release
RUN yum -y update
RUN yum -y install --allowerasing \
	gcc make elfutils-libelf-devel git
RUN yum -y install --allowerasing \
	openssl openssl-devel pesign dos2unix
RUN yum -y install rpm-build
RUN yum -y update kernel-headers-5.4.86
RUN yum -y downgrade annobin binutils cpp git-core rpm
RUN yum -y downgrade openssl glibc-headers libcurl gdb-headless make guile
RUN rpm -ivh shim-unsigned-x64-15.6-1.el8.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -D 'dist .el8' -bb /builddir/build/SPECS/shim-unsigned-x64.spec
COPY shimia32.efi /
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-ia32-15.6-1.el8.x86_64.rpm  | cpio -diu
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15.6-1.el8.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/15.6-1.el8/*/shim*.efi
RUN sha256sum ./usr/share/shim/15.6-1.el8/x64/shimx64.efi ./usr/share/shim/15.6-1.el8/ia32/shimia32.efi /shimia32.efi /shimx64.efi
RUN hexdump -Cv ./usr/share/shim/15.6-1.el8/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv ./usr/share/shim/15.6-1.el8/ia32/shimia32.efi > built-ia32.hex
RUN hexdump -Cv /shimia32.efi > orig-ia32.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /usr/share/shim/15.6-1.el8/x64/shimx64.efi
RUN objdump -h /usr/share/shim/15.6-1.el8/ia32/shimia32.efi
RUN diff -u orig-ia32.hex built-ia32.hex
RUN diff -u orig-x64.hex built-x64.hex
RUN cmp ./usr/share/shim/15.6-1.el8/x64/shimx64.efi /shimx64.efi
RUN cmp ./usr/share/shim/15.6-1.el8/ia32/shimia32.efi /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/15.6-1.el8/ia32/shimia32.efi
RUN pesign -h -P -i /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/15.6-1.el8/x64/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/15.6-1.el8/x64/shimx64.efi /shimx64.efi /usr/share/shim/15.6-1.el8/ia32/shimia32.efi /shimia32.efi
