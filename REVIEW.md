# Reviewer guidelines

Here's a **non-exhaustive** set of things to look for when reviewing a
shim submission.

There are some **meta** things to consider:

1. Does the developer have a good grasp of shim, the chain of trust
   etc.? We've had some submissions where people had not spent any
   time learning how to do shim/grub/kernel etc. (so we would **not**
   want to sign their key). In other cases, people have wanted to
   learn more, and the review process has acted as education. (We're
   working on better documentation to make this less painful.)

1. Does the vendor actually **need** to get a signed shim? Some are
   not clear about this. If they don't need to run on ~all machines,
   they can just sign things themselves.  If they don't **need** to 
   customize the kernel, they should reuse shim+grub2+kernel from
   another signed distro instead.

1. Does the vendor look like they might actually be around to deal
   with security issues in the future? A tiny 1-man outfit may just go
   away without warning.

And some concrete things:

1. Is the submitter from a new vendor that has not previously
   submitted to the repository?  If so verification of submitter email
   address ownership needs to be performed before review can continue.

1. Is the submitter’s build reproducible?  If you cannot reproduce
   their build and match the hashes on the submission, the submitter
   must make appropriate fixes and try again.

   1. Note that there may be some known issues with reproducibility in
      arm-based shim submissions, which are acceptable **for now** if
      the source is well understood.

1. Is the submitter’s shim built from source code of known provenance, i.e. rhboot/shim?
   If there are patches applied that aren’t authored by contributors
   to rhboot/shim are they adequately explained and well understood?

1. Did the submitter answer all the questions on the review template
   and in their review repository’s README.md?

1. Does the submitter’s embedded certificate match the organization
   they are submitting under, and can they explain why if not?

1. Does the submitter have reasonable access controls in place
   (e.g. HSM, etc.)  for the private half of the public key embedded
   in their shim?

1. Does the submitter’s embedded certificate have a reasonable
   validity period? For a straight certificate, 1 to 5 years is
   probably sensible. For an embedded CA cert, longer is fine (20
   years?)

1. Is SBAT data present in the provided binaries, and does it match
   what was provided in the answers to issue template questions?

   1. Is the vendor extension sensible? A clear unique name is good,
      something that's too likely to clash with another vendor is
      bad. Too long or too short an extension is not wanted, etc.

   1. If a binary is derived from a build from another distro, it's
      helpful to **also** include the details of that build and distro
      in the SBAT. This will make it easier to revoke things if we
      find that a whole family of builds are all broken due to a
      shared vendor patch.

1. Does the submitter use GRUB as a bootloader?  If not, additional
   full review by someone who is capable of performing it will be
   required.

1. If grub is used:
   1. Does it have the patches stated by the issue template and README.md?
   2. Are there any custom patches applied?  If so, are they explained
      by the submitter and well understood? This can be **very**
      time-consuming to do right - if a vendor is doing their own
      novel patches we may need to get more reviews.

1. What kernel is loaded, and does it have all the patches stated by
   the issue template and README.md?

1. Does the submitter adequately explain how revocation is achieved if
   they are patching a vulnerable shim that is already released?

1. Does the submitter adequately address how secure boot is enforced
   in their boot stack and how their boot stack prevents execution of
   unauthenticated code?
