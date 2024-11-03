config_opts['chroot_setup_cmd'] = 'install autoconf automake bash bash-completion bison bpftool bzip2 bzip2-devel cairo-devel cairo-gobject-devel cmake-filesystem coreutils cpio dejavu-sans-fonts device-mapper-devel diffutils dmidecode dwarves efivar-devel elfutils-devel elfutils-libelf-devel findutils flashrom flashrom-devel flex fontconfig fontconfig-devel freetype freetype-devel fribidi-devel fuse-devel gawk gcc gcc-c++ gcc-plugin-devel gettext gettext-devel git-core glib2-devel glibc-static gnu-efi gnu-efi-compat gnu-efi-devel gnutls-c++ gnutls-dane gnutls-devel gnutls-utils gobject-introspection-devel google-noto-cjk-fonts-common google-noto-sans-cjk-ttc-fonts grep gzip help2man info json-c-devel json-glib-devel kernel-rpm-macros libX11-devel libXau-devel libXext-devel libXft-devel libXrender-devel libarchive-devel libcurl-devel libdatrie-devel libdrm-devel libgudev-devel libgusb-devel libidn2-devel libjcat libjcat-devel libpciaccess-devel libtasn1-devel libtasn1-tools libthai-devel libtool libvala libxcb-devel libxml2-devel libxmlb libxmlb-devel make meson ncurses-devel nettle-devel ninja-build openssl openssl-devel p11-kit-devel pango-devel patch perl-devel perl-generators pesign pixman-devel polkit-devel polkit-docs protobuf-c python3 python3-cairo python3-devel python3-gobject python3-gobject-base python3-gobject-base-noarch python3-jinja2 python3-mako python3-markdown redhat-release redhat-rpm-config rpm-build rpm-devel rpmdevtools sed shadow-utils softhsm sqlite sqlite-devel squashfs-tools systemd systemd-boot-unsigned systemd-devel tar texinfo tpm2-tss-devel unbound-libs unzip util-linux vala valgrind valgrind-devel vim which xorg-x11-proto-devel xz xz-devel'
config_opts['dist'] = 'el9'  # only useful for --resultdir variable subst
config_opts['releasever'] = '9'
config_opts['package_manager'] = 'dnf'
config_opts['extra_chroot_dirs'] = [ '/run/lock', ]
config_opts['bootstrap_image'] = 'quay.io/rockylinux/rockylinux:9'

config_opts['plugin_conf']['bind_mount_enable'] = True
config_opts['plugin_conf']['bind_mount_opts']['dirs'].append(('/etc/pki/pesign', '/etc/pki/pesign' ))
config_opts['plugin_conf']['bind_mount_opts']['dirs'].append(('/usr/libexec/pesign', '/usr/libexec/pesign' ))
config_opts['plugin_conf']['bind_mount_opts']['dirs'].append(('/var/run/pesign', '/var/run/pesign' ))
config_opts['plugin_conf']['bind_mount_opts']['dirs'].append(('/var/lib/softhsm', '/var/lib/softhsm' ))
config_opts['nspawn_args'] += ['--bind=/etc/pki/pesign']
config_opts['nspawn_args'] += ['--bind=/usr/libexec/pesign']
config_opts['nspawn_args'] += ['--bind=/var/lib/softhsm']
config_opts['nspawn_args'] += ['--bind=/var/run/pesign']

config_opts['dnf.conf'] = """
[main]
keepcache=1
debuglevel=2
reposdir=/dev/null
logfile=/var/log/yum.log
retries=20
obsoletes=1
gpgcheck=0
assumeyes=1
syslog_ident=mock
syslog_device=
metadata_expire=0
mdpolicy=group:primary
best=1
install_weak_deps=0
protected_packages=
module_platform_id=platform:el9
user_agent={{ user_agent }}


[baseos]
name=Rocky Linux $releasever - BaseOS
baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/BaseOS/$basearch/os/
gpgcheck=1
enabled=1
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-9

[appstream]
name=Rocky Linux $releasever - AppStream
baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/AppStream/$basearch/os/
gpgcheck=1
enabled=1
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-9

[crb]
name=Rocky Linux $releasever - CRB
baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/CRB/$basearch/os/
gpgcheck=1
enabled=1
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-9

[extras]
name=Rocky Linux $releasever - Extras
baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/extras/$basearch/os/
gpgcheck=1
enabled=1
metadata_expire=6h
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-9

[devel]
name=Rocky Linux $releasever - Devel WARNING! FOR BUILDROOT ONLY DO NOT LEAVE ENABLED
baseurl=http://dl.rockylinux.org/pub/rocky/$releasever/devel/$basearch/os/
gpgcheck=1
enabled=1
gpgkey=file:///usr/share/distribution-gpg-keys/rocky/RPM-GPG-KEY-Rocky-9
"""