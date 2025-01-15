#!/usr/bin/env bash
#########################################################################
# Script Name  : locale-fix.sh
# Description  : Fix for update-initramfs error
# Dependencies : locale-gen, update-initramfs
# Arguments    : none
# Author       : Richard Romig
# Email        : rick.romig@gmail.com
# Created      :
# Updated      : 14 Jan 2025
# Comment      :
# License      : GNU General Public License, version 2.0
#########################################################################

# Copyright © 2023, Richard B. Romig
# Email: rick.romig@gmail.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <https://www.gnu.org/licenses/>.

## Variables ##

script=$(basename "$0"); readonly script
readonly version="2.4.25014"

## Functions ##

show_intro() {
  local updated="14 Jan 2025"
  cat << _INTRO_
$script changes the setting to store locales in individual locale direectories
instead of a single archive file.

During some updates the following warning may occur:
  Warning: No support for locale: us_US.UTF-8
The problem is that /usr/share/initramfs-tools/hooks/root_locale is expecting
to see individual locale directories in /usr/lib/locale, but locale-gen is
configured to generate an archive file by default.

Version: $version, last updated on $updated.
_INTRO_
}

purge_update() {
  printf "\nPurging existing locales and changing default setting to not\n"
  printf "store compiled locale data in a single archive.\n"
  sudo locale-gen --purge --no-archive
  printf "Updating the existing initramfs.\n"
  sudo update-initramfs -u # -t (-t flag isn't listed in man page)
}

main() {
  sudo_login 2
  show_intro
  purge_update
  over_line "$script v$version"
  exit
}

## Execution ##

main "$@"
