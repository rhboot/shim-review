# Reviewer guidelines

Here's a **non-exhaustive** set of things to look for when reviewing a
shim submission.

Thanks to [Paul Nardini](https://github.com/pnardini) for the initial
text, now adapted and posted here!

## Meta issues

First of all, there are some higher-level things to consider:

1. Does the developer have a good grasp of shim, the chain of trust
   etc.? We've had some submissions where people had not spent any
   time learning how to do shim/grub/kernel etc. (so we would **not**
   want to approve their shim for signing). In other cases, people
   have wanted to learn more, and the review process has acted as
   education. (We're working on better documentation to make this less
   painful.)

1. Does the vendor actually **need** to get a signed shim? Some are
   not clear about this. If they don't need to run on ~all machines,
   they can just sign things themselves.  If they don't **need** to
   customise the kernel, they should reuse
   shim+grub/systemd-boot+kernel from another signed distro instead.

1. Does the vendor look like they might actually be around to deal
   with security issues in the future? A tiny 1-man outfit may just go
   away without warning.

1. If the developer hasn't done what we ask for, then **say so**. This
   can cover a range of things with different severities, e.g.

   1. Not using the correct upstream shim source is a no-no and a hard
      **FAIL**.

   1. Patches applied from upstream should be obvious and easy to
      identify, whether in shim or grub or systemd-boot or kernel. If
      this causes you to spend massively more effort in reviewing, then
      that is bad of course. Mention this kind of thing, and explain
      what the developer could do to make our lives (and hence their
      lives!) easier here.

   1. Not providing a Dockerfile that works, or one that makes it hard
      for you to see what's going on.

   1. Not providing all the details of their other binaries, or maybe
      being vague about them. It's easy to miss this kind of thing
      when submitting, and we should be looking for these. It's most
      likely just something's that been missed, but we should be
      expecting good, clear, accurate, **complete** submissions for
      shim review. Without that, we can't accept things safely.

Then we have some concrete things to look at technically:

## Is the review request complete?

Did the submitter answer all the questions on the review template and
in their review repository’s README.md? If not, say so clearly and
move on. If questions have not been answered clearly, ask for
clarification. **Ask for help** if you're not sure on anything.

## Contact verification

Is the submitter from a new vendor that has not previously submitted
to the repository?  If so, verification of submitter email address
ownership needs to be performed before review can be completed.

The submission should include details of PGP keys for each of the
contacts. Using those keys, send an encrypted message to each
of the contacts to verify their identity.

A common thing to do here is to send a list of random words to each
contact and ask them to copy them into the review issue. See [Steve's
script](https://git.einval.com/cgi-bin/gitweb.cgi?p=steve-scripts.git;a=blob;f=random-words)
if you need help with this.

## Build reproducibility

Is the submitter’s build reproducible? If you cannot reproduce their
build and match the hashes listed in the submission, the submitter
must make appropriate fixes and try again. Be clear about this in a
review - show the expected/published sha256sum, and the result from
the local build.

**Notes**

1. There **used** to be some known issues with reproducibility in
   arm-based shim submissions, which were accepted back then. This
   should no longer be the case - **shim 15.7** and **binutils 2.38**
   solved this problem.

2. A common issue is that submitted Dockerfiles may "bit-rot" over
   time. If they refer to ``Ubuntu Jammy``, for example, a new
   compiler version might appear in a future update and the build will
   differ. If this seems to be the case, clearly describe the issue in
   your review.

## Shim source

Is the submitter’s shim built from source code of known provenance,
i.e. rhboot/shim? Any patches applied must be adequately identified
and explained. If they do not come from known upstream contributors
(e.g. cherry-picks or backports from the official rhboot/shim tree),
then you should be extra-careful to review the changes. **Ask for
help** if you're not sure.

Ideally, the build should be made using the exact source tarball
referenced in the submission guidelines, but so long as the source is
**clearly** the same, then it's acceptable to use a git repo instead.

We can no longer accept shim signing submissions for versions before
**15.7**.

## Certificates

To check the details of the cert:

```
$ openssl x509 -inform der -in <cert.der> -text -noout
```

Does the submitter’s embedded certificate match the organization they
are submitting under, and can they explain why if not?

Does the submitter have reasonable access controls in place (e.g. HSM,
etc.) for the private key(s) they are using?

Does the embedded certificate have a reasonable validity period? For a
straight certificate, 1 to 5 years is probably sensible. For an
embedded CA cert, longer is fine (20 years?)

If the submitter is embedding a CA certificate, do they adequately
describe how the rest of their chain of keys/certificates is handled?

## SBAT

**SBAT** is ``Secure Boot Advanced Targeting``. You need to understand
how SBAT works, and you need to carefully check the submission SBAT
data:

Is SBAT data present in the provided binaries, and does it match what
was provided in the answers to issue template questions?

Is the vendor extension sensible? A clear, unique name is good,
something that's too likely to clash with another vendor is bad. Too
long or too short an extension is not wanted, etc.

If a binary is derived from a build from another distro, it's strongly
recommended to **also** include the details of that build and distro
in the SBAT. This will make it easier to revoke things if we find that
a whole family of builds are all broken due to a shared vendor patch.

## GRUB

Does the submitter use grub as a bootloader? This is the default
assumption in shim and review so far.

If grub is used:

1. Does it have the patches stated by the issue template and
   README.md?
1. Are there any custom patches applied?  If so, are they explained by
   the submitter and well understood? This can be **very**
   time-consuming to do right - if a vendor is doing their own novel
   patches we may need to get more reviews.
1. Which grub modules are built in? The smaller, the better here, for
   the sake of reduced attack surface. Some of the more obscure grub
   filesystem modules have patchy security history and are best left
   disabled.

## systemd-boot

Does the submitter use systemd-boot as a bootloader? This is also used
in certain distributions, but less common than grub.

If systemd-boot is used:

1. Is it used exclusively, or provided alongside grub as an alternative
   package?
1. Is it intended to be used with BLS
   ([Boot Loader Specification](https://uapi-group.org/specifications/specs/boot_loader_specification/))
   Type #1 or Type #2 third stages, or either?
1. Is it the minimum required version, or alternatively does it have
   the patches stated by the issue template and README.md, if any?
1. Does it include the appropriate SBAT metadata, and is the identifier
   separate from systemd-stub (if used, i.e.: Type #2 BLS)?
1. Are there any custom patches applied?  If so, are they explained by
   the submitter and well understood? This can be **very**
   time-consuming to do right - if a vendor is doing their own novel
   patches we may need to get more reviews.
1. For more information about systemd-boot's security posture, please
   consult [its documentation](https://github.com/systemd/systemd/blob/main/src/boot/efi/UEFI_SECURITY.md).

## Alternative second-stage bootloaders

If the submitter is **not** using grub or systemd-boot, additional full
review by someone who is capable of performing it will be required.
**Ask for help** if you're not sure.

## Kernel

What kernel is loaded, and does it have all the patches stated by the
issue template and README.md? Older kernels will need a lot of patches
applying to make SB work well, but more modern kernels are safer out
of the box.

## Revocation and security

If the submitter has already had a previous shim signed, then they
must also explain how revocation is achieved for old, vulnerable
binaries.

Does the submitter adequately address how secure boot is enforced in
their boot stack and how their boot stack prevents execution of
unauthenticated code?

## Working with shim-review GitHub issues

Except for sending the contact verification mails (see above), please
keep all communications in the issues.

We have a small set of labels that can be attached to review
submissions to help us track things. These should be
self-explanatory. The correct labels should also act to give clear
information to submitters. **If** you're a known reviewer you can
add/remove/modify labels as you see fit.

We should never add the ``accepted`` label until a submission is
considered complete and ready for signing. Once a submission has been
signed, submitters should be encouraged to mark their shim-review
issues as **closed**.
