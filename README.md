This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************

Gooroom Platform Forum (www.gooroom.kr).

Gooroom platforms are being developed in consideration of cloud-web-based work environments that perform all tasks on a secure browser. Cloud-web-based work environments store all data in cloud storage and work by utilizing the web-based application services provided by the cloud instead of the applications that were previously installed and running on user terminals.

Gooroom platform consists of Gooroom OS, Gooroom browser, Gooroom security technology, and Gooroom central management System

Korean companies such as HANCOM Inc.(www.hancom.com), AhnLab Inc.(www.ahnlab.com), and TmaxOS(www.tmax.co.kr), eActive(www.eactive.co.kr) are participating in the Gooroom Platform Forum.

*******************************************************************************
### What product or service is this for?
*******************************************************************************

Gooroom OS.
Gooroom OS is a Debian-based Linux distribution, and like other open source OSes, anyone can use the source code and binaries for free.
Gooroom OS is a secure OS that provides sufficient support for multilevel security. It was created to prepare for the transition to the cloud.

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************

Gooroom OS is an open source OS that anyone can use freely, such as Debian, Ubuntu, and Fedora.
Gooroom OS has been developed and released up to version 3.0.
Gooroom OS currently supports Secure Boot but, there is no SHIM signed by MS, Secure Boot is only available on PC that could register custom keys in UEFI.
If we get a shim signed by Microsoft, users around the world will be able to use Gooroom OS more easily and safely.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
This is our first submission. and our OS is custom build for secure reason.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: JongKyung Woo
- Position: Gooroom Director
- Email address: jongkyung.woo@gmail.com
- PGP key fingerprint: 4D3B 299E 25CB C5C5 7FCB 2801 C52A D23F D5E6 CAE9

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: YoungJun Park
- Position: Gooroom OS Engineer
- Email address: zunn@eactive.co.kr
- PGP key fingerprint: 4D3B 299E 25CB C5C5 7FCB 2801 C52A D23F D5E6 CAE9

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 15.7 shim release tar?
Please create your shim binaries starting with the 15.7 shim release tar file: https://github.com/rhboot/shim/releases/download/15.7/shim-15.7.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.7 and contains the appropriate gnu-efi source.

*******************************************************************************

Yes, we are using the source from https://github.com/rhboot/shim/releases/tag/15.7

*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************
[your url here]

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************
No patch applied

*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************
We have our own downstream implementation. We are also following on debian's patches and reflect these patches immediately
*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of grub affected by any of the CVEs in the July 2020 grub2 CVE list, the March 2021 grub2 CVE list, the June 7th 2022 grub2 CVE list, or the November 15th 2022 list, have fixes for all these CVEs been applied?

* CVE-2020-14372
* CVE-2020-25632
* CVE-2020-25647
* CVE-2020-27749
* CVE-2020-27779
* CVE-2021-20225
* CVE-2021-20233
* CVE-2020-10713
* CVE-2020-14308
* CVE-2020-14309
* CVE-2020-14310
* CVE-2020-14311
* CVE-2020-15705
* CVE-2021-3418 (if you are shipping the shim_lock module)

* CVE-2021-3695
* CVE-2021-3696
* CVE-2021-3697
* CVE-2022-28733
* CVE-2022-28734
* CVE-2022-28735
* CVE-2022-28736
* CVE-2022-28737

* CVE-2022-2601
* CVE-2022-3775
*******************************************************************************
We haven't used shim so far, so there is no such thing. Our gooroom-grub was developed based on GRUB2 2.06 which is not affected by the CVEs.

*******************************************************************************
### If these fixes have been applied, have you set the global SBAT generation on your GRUB binary to 3?
*******************************************************************************
[your text here]

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************
We haven't used shim so far, so there is no such thing.
In our new chain of trust, we will not use old GRUB2 affected by CVEs, but use our groroom-grub based on GRUB2 2.06.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************
We are following on "Debian 11"

-- See below of Debian 11's

It is applied the first two fixes during the boothole event and they are still there in all debian's signed kernels.

The kgdb fix is included in debian's current kernel sources, but debian don't enable kgdb anyway in debian's binary build.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
[your text here]

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
We don't use vendor_db.

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************
This is our first submission. We created the first (CA) certificate.

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************
Dockerfile is provided to reproduce this build

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
[your text here]

*******************************************************************************
### What changes were made since your SHIM was last signed?
*******************************************************************************
No changes. This is our first shim to receive the signature from MS.

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
7fb5db43feb7a0ade8bedd573eb044cede248501000865db2cb5745d2695ccea

*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************
The keys are kept in USB HSM that is under physical access control.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************
No

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( grub2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
*******************************************************************************
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,2,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.gooroom,1,Gooroom,shim,15.6+grm3u4,https://github.com/gooroom/shim

sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,1,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.debian,1,Debian,grub2,2.06-3,https://tracker.debian.org/pkg/grub2
grub.gooroom,1,Gooroom,gooroom-grub,2.06-3+grm3u5,https://github.com/gooroom/gooroom-grub

sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd,1,Firmware update daemon,fwupd,1.5.7,https://github.com/fwupd/fwupd
fwupd.gooroom,1,Gooroom,fwupd,1.5.7-4+grm3u1,https://github.com/gooroom/fwupd

*******************************************************************************
### Which modules are built into your signed grub image?
*******************************************************************************
boot part_gpt part_msdos fat ext2 normal configfile lspci ls reboot datetime time loadenv search help gfxmenu gfxterm gfxterm_menu gfxterm_background all_video png gettext linuxefi gcry_rsa test echo squash4 iso9660 exfat cpio_be cpio crypto gcry_sha256 gcry_sha512 tpm

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB or other)?
*******************************************************************************
https://github.com/gooroom/gooroom-grub, the full version number of our gooroom-grub is 2.06-3+grm3u5.
It is derived from the Debian Bullseye upstream 2.06-3 release with a number of patches applied - see debian/patches there.

*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************
It launches fwupd.

*******************************************************************************
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************
None - it only launches a signed kernel in SecureBoot mode.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************
We are following on "Debian 11"

-- See below of Debian 11's

Debian's signed Linux packages have a common set of lockdown patches.
Debian's signed grub2 packages include common secure boot patches so they will only load appropriately signed binaries.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
*******************************************************************************
N/A

*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************
Debian linux kernel(v5.10.120-1)

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************
N/A
