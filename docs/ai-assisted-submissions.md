# AI-assisted shim submissions policy

shim is a security-critical first-stage component of the Secure Boot chain. A
shim-review submission is not a formality: it is evidence that the submitter
understands, can reproduce, and will maintain the submitted trust chain.

Generative-AI tools may be used to assist with a shim-review submission. They
do not reduce any technical, legal, or security requirements.

## Submitter responsibility

The human submitter is responsible for every part of the submission, including
the submitted binaries, source code, patches, build instructions and logs,
answers in the submission README, and communications during review.

Before submitting, the submitter must:

- Review and understand all generated or assisted content.
- Be able to explain, in their own words, the Secure Boot design, trust
  relationships, build process, patches, revocation strategy, SBAT metadata,
  test results, and security consequences of the submission.
- Verify that every factual claim and technical answer is accurate and complete.
- Remain available to answer reviewer questions directly and to make required
  corrections.

AI tools cannot be a security contact, author, signer, or the party responsible
for a submission.

## Reviewability and enforcement

Reviewers are not responsible for turning unreviewed tool output into a safe
shim submission.

A submission may be rejected without detailed technical review if reviewers
cannot establish that the submitter understands and owns the submission, or if
the submission is incomplete, inaccurate, internally inconsistent, excessively
verbose, or otherwise creates an unreasonable review burden.

In particular, a submission that appears to have been produced predominantly by
generative AI, without sufficient human understanding and verification
demonstrated through the submitted evidence and review discussion, will be
rejected.

Reviewers may request clarification, additional evidence, narrower and more
specific answers, source provenance, prompts or a summary of AI assistance,
additional testing, or a resubmission prepared by the responsible human
maintainer. Reviewers may also decline to review a submission when those
requests are not met.

This policy does not establish a safe percentage of AI-generated material.
The relevant question is whether a responsible human demonstrably understands,
verifies, and can maintain the security-critical submission.
