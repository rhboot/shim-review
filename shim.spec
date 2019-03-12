Name:           shim
Version:        0.8
Release:        1%{?dist}
Summary:        First-stage UEFI bootloader

License:        BSD
URL:            http://www.codon.org.uk/~mjg59/shim/
Source0:        https://github.com/mjg59/%{name}/releases/download/%{version}/%{name}-%{version}.tar.bz2
Source1:        NSDLca.cer	

# currently here's what's in our dbx:
# grub2-efi-2.00-11.fc18.x86_64:
# grubx64.efi 6ac839881e73504047c06a1aac0c4763408ecb3642783c8acf77a2d393ea5cd7
# gcdx64.efi 065cd63bab696ad2f4732af9634d66f2c0d48f8a3134b8808750d378550be151
# grub2-efi-2.00-11.fc19.x86_64:
# grubx64.efi 49ece9a10a9403b32c8e0c892fd9afe24a974323c96f2cc3dd63608754bf9b45
# gcdx64.efi 99fcaa957786c155a92b40be9c981c4e4685b8c62b408cb0f6cb2df9c30b9978
# woops.
Source2:	dbx.esl

BuildRequires: git openssl-devel openssl
BuildRequires: pesign >= 0.106-1
BuildRequires: gnu-efi >= 3.0w
BuildRequires: gnu-efi-devel >= 3.0w

# Shim uses OpenSSL, but cannot use the system copy as the UEFI ABI is not
# compatible with SysV (there's no red zone under UEFI) and there isn't a
# POSIX-style C library.
# BuildRequires: OpenSSL
Provides: bundled(openssl) = 0.9.8zb

# Shim is only required on platforms implementing the UEFI secure boot
# protocol. The only one of those we currently wish to support is 64-bit x86.
# Adding further platforms will require adding appropriate relocation code.
ExclusiveArch: x86_64 aarch64

# Figure out the right file path to use
%if 0%{?rhel}
%global efidir redhat
%endif
%if 0%{?fedora}
%global efidir fedora
%endif

%description
Initial UEFI bootloader that handles chaining to a trusted full bootloader
under secure boot environments.

%package -n shim-unsigned
Summary: First-stage UEFI bootloader (unsigned data)

%description -n shim-unsigned
Initial UEFI bootloader that handles chaining to a trusted full bootloader
under secure boot environments.

%prep
%setup -q
git init
git config user.email "%{name}-owner@fedoraproject.org"
git config user.name "Fedora Ninjas"
git add .
git commit -a -q -m "%{version} baseline."
git am %{patches} </dev/null


%build
MAKEFLAGS=""
if [ -f "%{SOURCE1}" ]; then
	MAKEFLAGS="VENDOR_CERT_FILE=%{SOURCE1} VENDOR_DBX_FILE=%{SOURCE2}"
fi
make 'DEFAULT_LOADER=\\\\grubx64.efi' ${MAKEFLAGS} shim.efi MokManager.efi fallback.efi

%install
rm -rf $RPM_BUILD_ROOT
pesign -h -P -i shim.efi -h > shim.hash
install -D -d -m 0755 $RPM_BUILD_ROOT%{_datadir}/shim/
install -m 0644 shim.efi $RPM_BUILD_ROOT%{_datadir}/shim/shim.efi
install -m 0644 shim.hash $RPM_BUILD_ROOT%{_datadir}/shim/shim.hash
install -m 0644 fallback.efi $RPM_BUILD_ROOT%{_datadir}/shim/fallback.efi
install -m 0644 MokManager.efi $RPM_BUILD_ROOT%{_datadir}/shim/MokManager.efi
# now install our .debug files...
install -D -d -m 0755 $RPM_BUILD_ROOT/usr/lib/debug/%{_datadir}/shim/
install -m 0644 shim.efi.debug $RPM_BUILD_ROOT/usr/lib/debug/%{_datadir}/shim/shim.efi.debug
install -m 0644 fallback.efi.debug $RPM_BUILD_ROOT/usr/lib/debug/%{_datadir}/shim/fallback.efi.debug
install -m 0644 MokManager.efi.debug $RPM_BUILD_ROOT/usr/lib/debug/%{_datadir}/shim/MokManager.efi.debug

%files -n shim-unsigned
%doc
%dir %{_datadir}/shim
%{_datadir}/shim/*

%changelog
* Tue Oct 14 2014 Peter Jones <pjones@redhat.com> - 0.8-1
- Update to 0.8
  Related: rhbz#1148230
  Related: rhbz#1148231
  Related: rhbz#1148232

* Wed Nov 06 2013 Peter Jones <pjones@redhat.com> - 0.7-1
- Fix logic to handle SetupMode efi variable.

* Thu Oct 31 2013 Peter Jones <pjones@redhat.com> - 0.6-1
- Fix a FreePool(NULL) call on machines too old for SB

* Fri Oct 04 2013 Peter Jones <pjones@redhat.com> - 0.5-1
- Update to 0.5

* Tue Jun 11 2013 Peter Jones <pjones@redhat.com> - 0.4-1
- Update to 0.4

* Fri Jun 07 2013 Peter Jones <pjones@redhat.com> - 0.3-2
- Require gnu-efi-3.0q for now.
- Don't allow mmx or sse during compilation.
- Re-organize this so all real signing happens in shim-signed instead.
- Split out mokutil

* Wed Dec 12 2012 Peter Jones <pjones@redhat.com> - 0.2-3
- Fix mokutil's idea of signature sizes.

* Wed Nov 28 2012 Matthew Garrett <mjg59@srcf.ucam.org> - 0.2-2
- Fix secure_mode() always returning true

* Mon Nov 26 2012 Matthew Garrett <mjg59@srcf.ucam.org> - 0.2-1
- Update shim
- Include mokutil
- Add debuginfo package since mokutil is a userspace executable

* Mon Oct 22 2012 Peter Jones <pjones@redhat.com> - 0.1-4
- Produce an unsigned shim

* Tue Aug 14 2012 Peter Jones <pjones@redhat.com> - 0.1-3
- Update how embedded cert and signing work.

* Mon Aug 13 2012 Josh Boyer <jwboyer@redhat.com> - 0.1-2
- Add patch to fix image size calculation

* Mon Aug 13 2012 Matthew Garrett <mjg@redhat.com> - 0.1-1
- initial release
