# shim-review HCL demo submission - SoftHSM

This is a demonstration of an HCL submission where SoftHSM is used on a Fedora 38 machine to build and sign Rocky Linux 9 bootloader components (GRUB2 only to keep it more simple), with pesign running in client-server mode in a mock environment.

It's purpose is to showcase, what kind of assumptions need to be met, what package versions (shipped by their respective vendors) have been used and what workarounds were needed to make the token work well, e.g. disabling SELinux, changing file permissions, generating test certificates, among others.

Naturally this is just a demonstration meant to be run in a laboratory/test environment to grasp the ideas in an easy-to-follow way. Hence why certain simplifications have been made, like generating keys and certificates outside a token, or how that token can be easily copied and provides no hardware protection. When submitting your own HCL entry, showcase the community the power of your hardware token's security!

Run the test environment:

```
$ vagrant destroy -f ; vagrant up --provision ; sleep 60 ; vagrant up --provision
```
