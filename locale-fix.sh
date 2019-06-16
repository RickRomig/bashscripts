#!/bin/bash
#########################################################################
#Script Name  :locale-fix.sh
#Description  :Fix for update-initramfs error
#Dependencies :locale-gen, update-initramfs
#Args         :Name of script to insert license into
#Author       :Richard Romig
#Email        :rick.romig@gmail.com
#Comment      :During some updates the following warning may occur:
# Warning: No support for locale: us_US.UTF-8
# The problem is that /usr/share/initramfs-tools/hooks/root_locale
# is expecting to see individual locale directories in /usr/lib/locale,
# but locale-gen is configured to generate an archive file by default.
#########################################################################
# Copyright (C) 2018  Richard Romig
# Email: rick.romig@gmail.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program. If not, see <https://www.gnu.org/licenses/>.
#########################################################################

# Remove existing locales & do not store compiled locale data in a single archive
echo "Purging existing locales."
echo "Changing default setting to not use a single archive for locale data."
sudo locale-gen --purge --no-archive
# Update existing initramfs & take over a custom initramfs with this one
echo "Updating existing initramfs."
sudo update-initramfs -u -t
exit

