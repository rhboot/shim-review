# Submitting a shim build

Here's a quick guide to the process for getting a shim build reviewed and
signed. The other, more detailed docs are listed here: (one as of today)

- [Guidelines for reviewers](./reviewer-guidelines)

If anything here or in the submission templates is not clear, please
ask for help before you spend a lot of time on an incorrect path.

## 0. Do you need and can you support a signed shim build?

These may sound like odd questions!

Are you 100% sure that you **need** a shim build including your vendor
key? Not everybody needs this; for small deployments it's often
possible (and easier!) to add public keys directly into firmware on
the machines involved. If you're a hardware vendor and you have
control over the firmware on machines that you ship, install your keys
into the other keyrings by preference. If you expect your software to
be directly used on a larger number of machines from multiple hardware
vendors, then shim is a more reasonable path to follow.

**Before** you start working with shim, you should also plan for how
to support your build in the long run. As a minimum, reviewers will
need two sets of contact details for people who will be responsible
for it going forwards. We may need to get in touch as and when
security issues appear in future. Depending on the nature of such
issues, you may need to revoke signatures and keys and/or build a new
version of shim with new patches included. If you are not sure you
will be able to commit to this, then shim may not be a good option for
you.

## 1. Sign up with Microsoft

If you're sure you need your own shim binary signed by Microsoft,
first go and create an account etc. with them. Check
[Microsoft's signing policies](https://techcommunity.microsoft.com/t5/hardware-dev-center/updated-uefi-signing-requirements/ba-p/1062916)
for all their specific requirements.

## 2. Build and test shim

Start with the current stable release of shim, and check for any
further recommended patches that you might need. Configure and build,

Check that you understand how to handle various things: embedding
keys, revoking the ability to load further binaries (both by signature
and by checksum), etc.

**Test** your shim build as much as you can - this is important. Early
testing is possible in VMs, and this is recommended as it's much
quicker and easier than fighting with real hardware. Of course, you
will **also** want to test that things work well on a range of
real-world hardware before you submit.

## 3. Prepare for submission for review

Once you're happy that your build works, it's time to prepare for
submitting it. This may seem long-winded, but the better you make your
submission the easier it will be for reviewers to mark your build as
accepted.

### 3.1 SBAT data

**SBAT** is ``Secure Boot Advanced Targeting``. It's a method to
efficiently handle revocation of old insecure Secure Boot binaries,
introduced in shim for the 15.3 release. The
[SBAT spec](https://github.com/rhboot/shim/blob/main/SBAT.md) and
[SBAT examples](https://github.com/rhboot/shim/blob/main/SBAT.example.md)
documents have a lot more information about how it works, and what's
needed.

If you are generating Secure Boot binaries (i.e. shim and the programs
it will run), you will need to add SBAT data to all of them:

* Pick a clear short **vendor** name that will be unique. Don't use a
  name that's too short or too long! If the name is too short, it's
  more likely to clash with others.

* Work out the right **component_generation** (see the docs)

* If you are deriving your source from another vendor's build,
  **also** include their SBAT vendor data. This helps the community
  track the provenance of changes (and bugs), and allows us to
  efficiently deal with publishing revocations in the future.

The shim build system provides an easy way to attach vendor SBAT data
provided in CSV form.

If you're not sure on any of this, please ask for advice before
submission!

### 3.2 Certificates and keys and revocations

You'll need to embed certificate data into your shim build, of
course - this is the purpose of shim! You can include multiple
certificates if desired.

You may also need to include lists of revocations. For example, you
may need to revoke old binaries or signatures after a security hole
has been discovered. It's possible to revoke a certificate (and
therefore all signatures from it), and also to directly disable
loading individual binaries by checksum.

There are strong recommendations on the types of certificates that
should be used in shim, and also on how keys should be managed for
security. See the 12th bullet in [Microsoft UEFI Signing
Requirements](https://techcommunity.microsoft.com/t5/hardware-dev-center/updated-uefi-signing-requirements/ba-p/1062916)
for tips on this, and also some sugested schems for key and certificate
management.

### 3.3 Reproducible build

Reviewers will need to validate that they can reproduce your shim
build. This is critically important - nobody will trust and sign a
binary that is not reproducible.

The **best** recommendation here is for you to create a Dockerfile
that will do the right thing to reproduce your build. This is **not**
mandatory, but not following the normal path here makes it harder for
reviewers.

If you are a Linux distribution developer, please try to have this
docker image set up your normal build environment and build just like
you would for your distribution; it'll make it easier to compare
results that way. **Be careful** with the choice of compiler etc. here
also - if you're tracking an "unstable" or "rolling" distribution then
a different compiler version may cause your binary to not match the
binary that a reviewer builds a week later.

If you are a tool developer needing a signed shim, pick a stable base
image to use for your Dockerfile and make it easy for reviewers.

If you absolutely **cannot** use a container image for some reason,
find another similar way to proceed and write clear easy docs for the
reviewer to follow.

In all cases, make things as straightforward as possible for your
reviewer and they'll be much happier to help you!

* Please have a docker build use a standard setup: ``docker build
  .`` is easy for reviewers. If you need a wrapper script to do
  things, call that from the Dockerfile.

* Please have your build script print the checksum(s) of your
  shim binaries, both the newly-built shim and the binary you're
  including in your submission.

### 3.4 Shim sources and patches

Again, make sure that you're using the current stable release of
shim. If you're not, reviewers will simply reject your submission and
ask you to start again.

Check that you have picked up any upstream patches recommended for
your use cases. To help with this, there should be tracking issues pinned in
the [shim-review](https://github.com/rhboot/shim-review/issues)
issues list which includes details of current patches recommended for
inclusion.

If you add any patches from upstream like this, again
**please** make it easy for reviewers to verify what the patches
are. ``git format-patch`` is your friend here - patch file names,
commit hashes and commit messages will all help the reviewer here.

If you have your **own** patches to shim, these will of course take
more time and effort for review. In all cases, please try to open
upstream PRs for them and/or discuss them on the EFI mailing list
first! If you have non-trivial changes, make sure that you explain
exactly what your changes are and why you need them. Shim is
security-critical and reviewers will need to understand your changes
and verify that they do not cause security regressions.

Similarly, shim is normally used to load GRUB or systemd-boot as the
system bootloader. if you're doing something different, this will need
deeper review. Please make it as easy as possible for reviewers to
understand what you're doing (and why!) if you want them to accept your
shim for signing.

### 3.5 Sources and patches for other components

Reviewers will expect to be able to inspect your GRUB or systemd-boot
sources to validate the state of Secure Boot patches in particular, and
will normally also ask about patches to other system components like
Linux and fwupd. We need to consider the security of the entire boot
chain here - shim is just the first step.
