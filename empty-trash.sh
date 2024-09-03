#!/usr/bin/env bash
###############################################################################
# Script Name  : empty-trash.sh
# Description  : Empty the local trash directory
# Dependencies : trash-cli tree 'sudo apt install trash-cli tree'
# Arguments    : none
# Author       : Copyright © 2023, Richard B. Romig, Mosfanet
# Email        : rick.romig@gmail.com | rick.romig@mymetronet.com
# Created      : 21 Nov 2023
# Last updated : 03 Sep 2024 Version 2.6.24247
# Comments     : Run as a user cron job.
#              : Trash directory does not exist until a file is moved to the trash.
#              : Tested with Debian 11/12, LMDE 6, Mint 21.x, Mint 22, MX Linux 23.1, BunsenLabs 11.
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
	if [[ $(find "$trash_dir"/info -type f | wc -l) -gt 0 ]]; then
		printf "\nTrash contents:\n---------------\n"
		if [[ -x /usr/bin/tree ]]; then
			tree -a "$trash_dir"
		else
			find "$trash_dir"/files -type f,d
			find "$trash_dir"/info -type f
		fi
		if [[ -x usr/bin/trash-empty ]]; then
			/usr/bin/trash-empty
		else
			find "$trash_dir"/files -mindepth 1 -type f,d -exec rm -rf {} +
			rm -f "$trash_dir"/info/*
		fi
		printf "\nTrash emptied.\n\n"
		if [[ -x /usr/bin/tree ]]; then
			tree -a "$trash_dir"
		else
			find "$trash_dir"/files -type f,d
			find "$trash_dir"/info -type f
		fi
	else
		printf "\nNo trash to empty.\n"
	fi
}

[[ -d "$log_dir" ]] || mkdir -p "$log_dir"

{
	printf "Date: %s \n" "$(date '+%F %R')"
	if [[ -d "$trash_dir" ]]; then
		empty_trash
	else
    printf "\nTrash directory does not exist.\n"
	fi
} > "$log_dir/$log_file" 2>&1
exit
