#!/bin/sh
#
# pve-nag-buster.sh (v04) https://github.com/foundObjects/pve-nag-buster
# Copyright (C) 2019 /u/seaQueue (reddit.com/u/seaQueue)
#
# Removes Proxmox VE 6.x+ license nags automatically after updates
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

NAGTOKEN="data.status.toLowerCase() !== 'active'"
NAGFILE="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"
SCRIPT="$(basename "$0")"

# disable license nag: https://johnscs.com/remove-proxmox51-subscription-notice/

if grep -qs "$NAGTOKEN" "$NAGFILE" > /dev/null 2>&1; then
  echo "$SCRIPT: Removing Nag ..."
  sed -i.orig "s/$NAGTOKEN/false/g" "$NAGFILE"
  systemctl restart pveproxy.service
fi

# disable paid repo list

ENTERPRISE_BASE="/etc/apt/sources.list.d/pve-enterprise"
CEPH_BASE="/etc/apt/sources.list.d/ceph"

if [ -f "$ENTERPRISE_BASE.list" ]; then
  echo "$SCRIPT: Disabling PVE enterprise repo list ..."
  mv -f "$ENTERPRISE_BASE.list" "$ENTERPRISE_BASE.disabled"
fi

if [ -f "$CEPH_BASE.list" ]; then
  echo "$SCRIPT: Disabling Ceph repo list ..."
  mv -f "$CEPH_BASE.list" "$CEPH_BASE.disabled"
fi
