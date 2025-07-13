## pve-nag-buster 

This is a fork of [foundObjects/pve-nag-buster](https://github.com/foundObjects/pve-nag-buster). I've appreciated how set-and-forget it has been. Recently, I needed to apply a few updates to fit my own needs, but the main repository hasn't seen activity for a while. As a result, I've created this fork.

`pve-nag-buster` is a dpkg hook script that persistently removes license nags
from Proxmox VE 6.x and up. Install it once and you won't see another license
nag until the Proxmox team changes their web-ui code in a way that breaks the patch.

Please support the Proxmox team by [buying a subscription](https://www.proxmox.com/en/proxmox-ve/pricing) if it's within your
means. High quality open source software like Proxmox needs our support!

### News:

Last Updates:
- New build method and offline-only install script.
- No-subscription repositories for Ceph ([divinity76](https://github.com/divinity76))
- `pve-manager/6.4-4/337d6701` (running kernel: `5.4.106-1-pve`)

### How does it work?

The included [hook script](https://raw.githubusercontent.com/wmil/pve-nag-buster/refs/heads/master/source/buster.sh)
removes the "unlicensed node" popup nag from the web-ui and disables the enterprise repository lists.
This script is called every time a package updates the web-ui or the enterprise source lists and
will only run if packages containing those files are changed.

The installer
installs the [dpkg hook script](https://raw.githubusercontent.com/wmil/pve-nag-buster/refs/heads/master/source/apt.conf.buster),
adds the [pve-no-subscription](https://github.com/wmil/pve-nag-buster/blob/master/source/apt.list.pve)
and [ceph-no-subscription](https://github.com/wmil/pve-nag-buster/blob/master/source/apt.list.ceph) repo lists
and calls the hook script once.
There are no external dependencies beyond the base packages installed with PVE by default.

### Installation
```sh
wget https://raw.githubusercontent.com/wmil/pve-nag-buster/master/install.sh

# Always read scripts downloaded from the internet before running them with sudo
chmod +x install.sh && sudo ./install.sh
```

### Uninstall:
```sh
sudo ./install.sh --uninstall
# remove /etc/apt/sources.list.d/{pve,ceph}-no-subscription.list if desired
```

### Thanks to:

- John McLaren for his [blog post](https://www.reddit.com/user/seaqueue) documenting the web-ui patch.
- [Marlin Sööse](https://github.com/msoose) for the update for PVE 6.3+

### Contact:

[Open an issue](https://github.com/foundObjects/pve-nag-buster/issues) on GitHub

Please get in touch if you find a way to improve anything, otherwise enjoy!

