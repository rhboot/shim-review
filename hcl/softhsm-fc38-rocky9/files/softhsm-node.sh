#!/bin/bash

set -euo pipefail

if test ! $(rpm --eval %fedora) = "38"; then
  echo "The script is meant to run on Fedora 38 only, terminating."
  exit 1
fi

sudo dnf install -y git grubby openssl pesign softhsm mock wget

sudo setenforce 0 || true
sudo grubby --update-kernel ALL --args selinux=0

sudo cp -n rocky-9-softhsm-x86_64.cfg /etc/mock/
sudo cp -n rocky-9-softhsm.tpl /etc/mock/templates/
sudo usermod -a -G mock,ods,pesign $USER

# The file "/etc/profile.d/softhsm-node-for-pesign.sh" will act as a flag indicating that the earlier tasks have succeeded - no need for multiple reboots
if test ! -f /etc/profile.d/softhsm-node-for-pesign.sh; then
  sudo bash -c 'echo "export PESIGN_TOKEN_PIN=\"Secret.123\"" > /etc/profile.d/softhsm-node-for-pesign.sh'
  echo "
  ---
  Rebooting the machine for the changes to take place.
  "
  sudo reboot
fi

if test ! -v PESIGN_TOKEN_PIN; then
  echo "PESIGN_TOKEN_PIN not set correctly, terminating."
  exit 1
fi

YOUR_UNIX_ACCOUNT_GROUPS="$(id -Gn $USER)"

if ! grep -q "mock pesign ods" <<< "${YOUR_UNIX_ACCOUNT_GROUPS}"; then
  echo "
  Expected your Unix account to be in the groups:
  \"mock pesign ods\"
  but got:
  \"${YOUR_UNIX_ACCOUNT_GROUPS}\",
  terminating.
  "
  exit 1
fi

# Initializations
mock -r rocky-9-softhsm-x86_64 --init
softhsm2-util --init-token --label HSM --so-pin ${PESIGN_TOKEN_PIN} --pin ${PESIGN_TOKEN_PIN} --free

# Example p12 generation and import
git clone https://github.com/rhboot/shim.git --depth 1
pushd shim
./make-certs example
pk12util -k <(echo "${PESIGN_TOKEN_PIN}") -w /dev/zero -i example.p12 -d /etc/pki/pesign -h HSM
popd

# Workarounds related to permissions
sudo chmod -R 777 /var/lib/softhsm/
sudo /usr/libexec/pesign/pesign-authorize
sudo chmod -R 777 /var/lib/softhsm/
sudo chmod -R 777 /etc/pki/pesign/
sudo systemctl enable pesign --now
sudo chmod -R 777 /var/run/pesign*

# Unlock the token in client-server mode
pesign-client -u -t HSM
pesign-client --is-unlocked --token HSM

# Example rebuild as a proof that it works
wget http://dl.rockylinux.org/vault/rocky/9.4/BaseOS/source/tree/Packages/g/grub2-2.06-82.el9_4.src.rpm
echo "ee074f84382f92401bc85cdac2942e3c0da928aa56329afe29b058db63857d99 *grub2-2.06-82.el9_4.src.rpm" | sha256sum -c
mock -r rocky-9-softhsm-x86_64 --define "pe_signing_token HSM" --define "pe_signing_cert example" --rebuild grub2-2.06-82.el9_4.src.rpm

echo "
---
It works alright.
"
