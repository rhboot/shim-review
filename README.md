This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch

Note that we really only have experience with using grub2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
[Guangdong Zhongxing Newstart Technology Co. ,Ltd]

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
[Newstart Desktop Linux V3]

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
[We're OS vendor]

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name:Chen Xiaoyuan
- Position:Engineer
- Email address:chen.xiaoyuan@zte.com.cn
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:
linux community:https://github.com/cxy-uestc/shim-review/tree/nsdl-3.0/chen.pub

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name:Gaoying
- Position:Engineer
- Email address:gao.ying101@zte.com.cn
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:
linux community:https://github.com/cxy-uestc/shim-review/tree/nsdl-3.0/gao.pub

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
[https://github.com/rhboot/shim/tree/0.8/]

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
[https://github.com/rhboot/shim/tree/0.8/]

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
[https://github.com/rhboot/shim/tree/0.8/]

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
[It's done on something very close to the Fedora 25. It can be built from the mock configure file at https://github.com/cxy-uestc/shim-review/tree/nsdl-3.0/nsdl-v3-x86_64.cfg plus the yum repo at https://github.com/cxy-uestc/shim-review/tree/nsdl-3.0/nsdl-3.0-shim-build-deps. nsdl-v3-x86_64.cfg can be used to reproduce the entire build using the release tarball from github. 
step1:create a user and its password in Fedora; 
step2:sudo dnf install mock with softwarecenter in /etc/yum.repos.d/
step3:build shim.src.rpm with shim tarball and shim.spec 
     mkdir shim/SOURCES shim/SPECS
     mv shim.tar shim/SOURCES/
     mv shim.spec shim/SPECS
     cd shim  & sudo rpmbuild -bs SPECS/*.spec --define="_topdir `pwd`"
step4:sudo mock -r nsdl-v3-x86_64 --rebuild shim-0.8-1.fc25.src.rpm --no-clean --no-cleanup-after
step5:shim binay package, build.log and root.log can be found at /DESKTOP/mock/nsdl-v3-X86_64/result/ ]

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
[build.log]

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
[root.log]
