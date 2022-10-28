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

-------------------------------------------------------------------------------
### What organization or people are asking to have this signed?
-------------------------------------------------------------------------------
Guangdong Zhongxing Newstart Technology Co. ,Ltd

-------------------------------------------------------------------------------
### What product or service is this for?
-------------------------------------------------------------------------------
Newstart Desktop Linux V4

-------------------------------------------------------------------------------
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
-------------------------------------------------------------------------------
We're OS vendor.

-------------------------------------------------------------------------------
### Who is the primary contact for security updates, etc.?
- Name:lvkaiyi
- Position:Engineer
- Email address:lv.kaiyi@gd-linux.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:
	-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBF4mxmMBCADLulGam1qXMGdFv8ACIpa+UgxnPLtbGiivIbQyvHd3rDoruKbH
9gqRmJTZ53uoFLWuGdlshTFUDMNwDvffpxt8lMRJE6S9YZ8m/XkQL3Esu1m7nk7n
DGswPrG1waMOF3T+XRwucs990zBmC8nGF6W6AhLWVDmbl4LWRVvF1sXlkdRt/3V+
v59x/7pi7G5dX2EoiGz9qMvcFtPuz9b3Qa9GnVTLtfvI/cRidYFzt5JrVw+2yWtU
bXBLdrMAWEJJKyefGL2Lmw2jfexcf8NxbBi8ARhb/ilU4P205SSX9XM64l7yhgqE
5+Y438po4Bs3COywY2T3tczD/EfHl7jq27qVABEBAAG0KGx2a2FpeWkgKFBHUEtl
eSkgPGx2LmthaXlpQGdkLWxpbnV4LmNvbT6JATgEEwECACIFAl4mxmMCGwMGCwkI
BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEB0Cp12ZeUEWK54H/RiTC/utxNL2nRah
NPMs9SQ9flrts9m7IM/RhtKJgMqnKhdQyPomD9Q0XKpfsQjB50n/4RS2Aey7bYj8
fqNis0uC4VwlOjvkiGm75v4In2BwrVPySz0MCmCaDHZFgCS4/pcGVQOQgz9D7RyL
E7VM6jNMqwgei+2uRkxJMkbyd9CJLNeNwwo4o9bincsa79s/pLkTm359pi9izVkI
+8FHMfWZvjd7qIiSmvnjPsM0kU8Fcu/h4R1n4yCzvbq6WR/BVuDruUSVX4yC88xe
E5vdkuY1teimEsr1+DuLbShO3BPjcrphrJhujgL6s7ac3V1JnYSOWBU9segvW0/a
pBP4vQy5AQ0EXibGYwEIAO9jBvJ8LKB96ArmirtzforfTdRmTzsJkH+BUidKQur3
ETjmt2ekQfsRrp5nlFZ9qT+J0/myfcgF9fbSjgNJyQSHcv3H1VxBbk6dGyRIxMqp
yFxDvBH0DihiOVl4aXGZJ9ztLnx3R0ywhC/9fa/UFW5D2Ynma/wmOdKsanZHrf3y
3HBA9/B4JtOi5D7Q1xl7xWw2MadrQ8g60zmaXUi/OxI79c92CxICkpKxnaxoGABs
AtqelcNNMH3lP5Fg2AvhAgrDnMVAread+N7LXJEjROnZdnUgks7bDKYQlcV5NI2t
z5pgF8brQR70A2iW6+6leZMhS8djisNGClHh9DTUqcsAEQEAAYkBHwQYAQIACQUC
XibGYwIbDAAKCRAdAqddmXlBFuj4B/0a04N+S/hrZ8SA20+Try8FMhJ6JYoL57tg
JM3uQej815ZunEU6ExwddVDz5d4mh+NDSh5f5S2E/nJ/8+V1YQPqSTeIONsPZQ/W
qaDIocj7xldt2/HDtLnJpVXGJouwqm34SMPRPYmPlisgCUml0OCWNA1VuLp3ehsp
fnXpYI5baZijaNwOeRNfHG4pJJd4ndKL5NEQ5gSiaQwK9Ts0vghJpgVxt+IPQ17Q
l01PszOtG8AsZ3zCMLcevGHBK7kbA8x+s7f2XIbmZVqQdZufBGLakLG/Ekw5vFPW
aK+Ynw60ipcIkGoYpDTTPLrVdk7QkAEbHWC1gzSrMmo89X1WUQOI
=4LA3
-----END PGP PUBLIC KEY BLOCK-----

-------------------------------------------------------------------------------
### Who is the secondary contact for security updates, etc.?
-------------------------------------------------------------------------------
- Name:maizhuodong
- Position:Engineer
- Email address:mai.zhuodong@gd-linux.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBF4myXoBCACoBBQTzQnkTPrBS0AfQStcHO7ymmvXo3Rvs0wBf9QEMe01aYi9
Ax6Sgn1FkodswD1Us06TWBTagrvEG+3+M0hURXI36k5t8EL9Eg76zd4+sZOXpDFY
uaTLympEJL25PxmvFOi6hbsQlgGMOsF+kS5PcaZPOJvX8RBIc2KG485g+KcQz962
xunRB10C/81LCZntFA9LDpGLedr5x5nkgpBqZL1Arkl2WcXUtuq8BF6q/ET7UPZy
91WBXYHrO7rfz/98xxGTcXVw8TYuR3KDg7+tqMiGRC6g28d7ZmNBQP0iJM4AgWHs
hL06/17/WxPKFmgm+L7RQ3zV2vH3k0JPugovABEBAAG0MG1haXpodW9kb25nIChQ
R1BLZXkpIDxtYWkuemh1b2RvbmdAZ2QtbGludXguY29tPokBOAQTAQIAIgUCXibJ
egIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQfxKPgCr0TOYwnAf+Nm1q
DTiANj3SlkK0bDO3vlfUqY8MCErQ3Zxx4AziEBgkKbdiuDkCTgdZWRPjUCr6NpgA
geQqkuNd/C9JxAzJRYG+XbHdYkU4jLTO9BqLiURJ5vmNWddfEeT6jmemuIFBDhRg
pHjPzknL8l70VGIk1xscdO6uCdJr4NKk1Gc1VT8kVtnFpgbXdgO2ePupPWG9Ft0U
7tZo7vVZ0fNY3pRo0MRZ+0G9YIPHYmB1Oi4qMIiiaJm6cI1cn1/tE4no0HaOon5b
5smqlPeF8hYbEra3SJxALDx9cvjyg/mVF1p91ef6NZQPXnmJf3C5j+CcNthtvPkK
v5va+1PmgGVMSdBPK7kBDQReJsl6AQgApFjZOPzbjrj5tsdUfxYFrfFvgD+RRJSg
VOJ7PrdzBiTyS0eO3sBs2FGlpaOo49mTcYMg4mVp0QM677OyPg6D0W9ZZ8Keatte
mj4Y79L0EAk7dXkv2N5LAFxq2MSKcl7kMntwObkph6B+TbpJ4bQYxqGgNG0zX/3h
NljUrJNPWeO+ZwwHbduvks04Oj2+xU/I72HHfd74rRi1VCk9qkQFjeOPbzQhZ4gf
FAMKFLoWGvcUWlwR9cQC0WBQdxXgtsf8QlLvsg08zxVcMBxzT7L6J80W7QOKFNhN
XuRVm2Q77jX9q1fkoUHpbVtQF6JtKDFNZ084uAwZk0FK16l/L7SEAwARAQABiQEf
BBgBAgAJBQJeJsl6AhsMAAoJEH8Sj4Aq9EzmGDUH/1dVCwJR/atkKx4tzVIw6ER4
SeSiPwY/sBiWYTThWg+1aiohGCAxWOmTXcaLm0a8eYu6233cAe2N3Bq1XzZgTymv
EXBbvTZceQzNGS+brj5yOhrl+UnV6BV3bAN3QBRyM6Dv9wnF3lUa8SXEBCdjF/AD
161KuxzdHGkQGDYfrDUiAmYO2AjtrUg7aZP87snedsm/aTwI+d/UvGwPtBQE0cNj
9bPatUWv2yeihh1hPf+V+zxpMMtjDt9cCqFI1kk7+dpV4qzN9SSKWzdWp7BlDbSr
F7Fd9wnopEid1PoXvyDU4TOPRyTXGrrwGsSsTpX2U8Ix6vTmMozkDIpxCsgBfQQ=
=evGb
-----END PGP PUBLIC KEY BLOCK-----

-------------------------------------------------------------------------------
### Were these binaries created from the 15.6 shim release tar?
Please create your shim binaries starting with the 15.6 shim release tar file: https://github.com/rhboot/shim/releases/download/15.6/shim-15.6.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.6 and contains the appropriate gnu-efi source.

-------------------------------------------------------------------------------
This is the unmodified shim-15.6 release.

-------------------------------------------------------------------------------
### URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/releases/download/15.6/shim-15.6.tar.bz2

-------------------------------------------------------------------------------
### What patches are being applied and why:
-------------------------------------------------------------------------------
None.

-------------------------------------------------------------------------------
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
-------------------------------------------------------------------------------
RHEL like implementation.

-------------------------------------------------------------------------------
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of grub affected by any of the CVEs in the July 2020 grub2 CVE list, the March 2021 grub2 CVE list, or the June 7th 2022 grub2 CVE list:
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

### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
-------------------------------------------------------------------------------
This is our first shim submission. Those CVEs are fixed in current version grub2-2.02-123.el8.

-------------------------------------------------------------------------------
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?

-------------------------------------------------------------------------------
Yes, it contains the first two commits mentioned above. 
We don't enable kgdb anyway in our binary builds, so the third commit is not applicable. 

-------------------------------------------------------------------------------
### Do you build your signed kernel with additional local patches? What do they do?
-------------------------------------------------------------------------------
No.

-------------------------------------------------------------------------------
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
-------------------------------------------------------------------------------
We don't use vendor_db functionality in this build.

-------------------------------------------------------------------------------
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
-------------------------------------------------------------------------------
We are not reusing any previously used CA, this is our first submission.

-------------------------------------------------------------------------------
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
-------------------------------------------------------------------------------
Dockerfile is provided to reproduce this build.

-------------------------------------------------------------------------------
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.

-------------------------------------------------------------------------------
build.log

-------------------------------------------------------------------------------
### What changes were made since your SHIM was last signed?
-------------------------------------------------------------------------------
New vendor - First submission.

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
sha256sum shimia32.efi
fa07390322fd0c3b913a2ea58f98e6e584b8d871025664327a9b7cfbd4cb7643  shimia32.efi
sha256sum shimx64.efi
841a5a2d59a91b2e4fc6e2a9309cd2240833f08b9aad417cbba62f1aaf909fd2  shimx64.efi

-------------------------------------------------------------------------------
### How do you manage and protect the keys used in your SHIM?
-------------------------------------------------------------------------------
The keys is split into 7 fragments with Shamir's Secret Sharing and stored offline in different city in our country.
To assemble or update the keys we should travel to those cities to get these fragments.

-------------------------------------------------------------------------------
### Do you use EV certificates as embedded certificates in the SHIM?
-------------------------------------------------------------------------------
No.

-------------------------------------------------------------------------------
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( grub2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
-------------------------------------------------------------------------------
shim:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,1,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.NewStartOS,1,NewStart,shim,15.5,mail:os@gd-linux.com

grub:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,1,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.NewStartOS,1,NewStart,grub2,2.02-123,mail:os@gd-linux.com

-------------------------------------------------------------------------------
### Which modules are built into your signed grub image?
-------------------------------------------------------------------------------
all_video boot blscfg btrfs cat configfile cryptodisk
echo efi_netfs efifwsetup efinet ext2 fat font gcry_rijndael
gcry_rsa gcry_serpent gcry_sha256 gcry_twofish gcry_whirlpool
gfxmenu gfxterm gzio halt hfsplus http increment iso9660 jpeg
loadenv loopback linux lvm lsefi lsefimmap luks mdraid09 mdraid1x
minicmd net normal part_apple part_msdos part_gpt password_pbkdf2
png reboot regexp search search_fs_uuid search_fs_file search_label
serial sleep syslinuxcfg test tftp video xfs
-------------------------------------------------------------------------------
### What is the origin and full version number of your bootloader (GRUB or other)?
-------------------------------------------------------------------------------
grub2-2.02-123.el8
https://github.com/LiangJianNSDL/shim-review/blob/nsdl-v4-shim-amd64-i386/grub2-2.02-123.el8.src.rpm

-------------------------------------------------------------------------------
### If your SHIM launches any other components, please provide further details on what is launched.
-------------------------------------------------------------------------------
The Shim only launches GRUB2.

-------------------------------------------------------------------------------
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
-------------------------------------------------------------------------------
We only launch the Linux kernel.

-------------------------------------------------------------------------------
### How do the launched components prevent execution of unauthenticated code?
-------------------------------------------------------------------------------
Signed linux images have lockdown enabled.
GRUB2 has Secure Boot patches applied and only launches our signed files.

-------------------------------------------------------------------------------
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
-------------------------------------------------------------------------------
No.

-------------------------------------------------------------------------------
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
-------------------------------------------------------------------------------
It's based on 5.4.86, plus a full compliment of patches for Secure Boot and
relevant bug fixes.

-------------------------------------------------------------------------------
### Add any additional information you think we may need to validate this shim.
-------------------------------------------------------------------------------
No.
