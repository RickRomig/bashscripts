#!/usr/bin/env bash
###############################################################################
# Script Name  : empty-trash.sh
# Description  : Empty the local trash directory
# Dependencies : none
# Arguments    : none
# Author       : Copyright © 2023, Richard B. Romig, Mosfanet
# Email        : rick.romig@gmail.com | rick.romig@mymetronet.com
# Created      : 21 Nov 2023
# Last updated : 17 Mar 2024 Version 0.1.4
# Comments     : Run as a user cron job daily, weekly, or monthly
#              : Trash directory does not exist until a file is moved to the trash.
#              : Tested with Debian 11/12, LMDE 6, Mint 21.x, MX Linux 23.x, BunsenLabs 11.
# License      : GNU General Public License, version 2.0
###############################################################################
#
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

readonly trash_dir="$HOME/.local/share/Trash"
readonly log_dir="$HOME/.local/share/logs"
readonly log_file="trash.log"

empty_trash() {
	if [[ $(find "$trash_dir/files" -type f | wc -l) -gt 0 ]]; then
		printf "Trash contents:\n"
		find "$trash_dir/files" -type f -exec basename {} \;
		rm -rf "$trash_dir"/files/*
		rm -f "$trash_dir"/info/*
		printf "Trash emptied.\n"
	else
		printf "No trash to empty.\n"
	fi
}

[[ -d "$log_dir" ]] || mkdir -p "$log_dir"

{
	printf "Trash log\nDate: %s \n" "$(date '+%F %R')"
	if [[ -d "$trash_dir" ]]; then
		empty_trash
	else
    printf "Trash directory does not exist.\n"
	fi
} > "$log_dir/$log_file" 2>&1
exit
