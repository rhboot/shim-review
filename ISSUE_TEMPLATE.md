Make sure you have provided the following information:

 - [ ] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [ ] completed README.md file with the necessary information
 - [ ] shim.efi to be signed
 - [ ] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [ ] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes whitelisted )
 - [ ] any extra patches to shim via your own git tree or as files
 - [ ] any extra patches to grub via your own git tree or as files
 - [ ] build logs


###### What organization or people are asking to have this signed:
`[your text here]`

###### What product or service is this for:
`[your text here]`

###### What is the origin and full version number of your shim?
`[your text here]`

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
`[your text here]`

###### How do you manage and protect the keys used in your SHIM?
`[your text here]`

###### Do you use EV certificates as embedded certificates in the SHIM?
`[your text here]`

###### If you use new vendor_db functionality, are any hashes whitelisted, and if yes: for what binaries ?
`[your text here]`

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a linux kernel ?
`[your text here]`

###### if SHIM is loading grub2 bootloader, is CVE CVE-2020-10713 fixed ?
`[your text here]`

##### Were your old SHIM hashes provided to Microsoft ?
`[your text here]`

##### Did you change your certificate strategy, so that affected by CVE CVE-2020-10713 grub2 bootloaders can not be verified ?
`[your text here]`

###### What is the origin and full version number of your bootloader (GRUB or other)?
`[your text here]`

###### If your SHIM launches any other components, please provide further details on what is launched
`[your text here]`

###### How do the launched components prevent execution of unauthenticated code?
`[your text here]`

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
`[your text here]`

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
`[your text here]`

###### What changes were made since your SHIM was last signed?
`[your text here]`

###### What is the hash of your final SHIM binary?
`[your text here]`
