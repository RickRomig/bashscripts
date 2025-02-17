#!/usr/bin/env bash
###############################################################################
# Script Name  : empty-trash.sh
# Description  : Empty the local trash directory
# Dependencies : trash-cli 'sudo apt install trash-cli'
# Arguments    : none
# Author       : Copyright © 2023, Richard B. Romig, Mosfanet
# Email        : rick.romig@gmail.com | rick.romig@mymetronet.com
# Created      : 21 Nov 2023
# Updated      : 28 Sep 2024
# Comments     : Run as a user cron job.
#              : Trash directory does not exist until a file is moved to the trash.
#              : Removes files that have been in the trash folder more than a week.
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

trash() {
	local count; count=$(/usr/bin/trash-list | wc -l)
	[[ "$count" -gt 0 ]] && return 0 || return 1
}

empty_trash() {
	local last_week; last_week=$(date -d "$(date) - 7 days" +%F)
	if trash; then
		printf "\nTrash contents:\n"
		/usr/bin/trash-list
		printf "\nRemoving trash older than %s...\n" "$last_week"
		/usr/bin/trash-empty 7
		if trash; then
			printf "\nTrash newer than %s...\n" "$last_week"
			/usr/bin/trash-list
		else
			printf "\nAll trash removed.\n"
		fi
	else
		printf "\nThe trash can is empty.\n"
	fi
}

main() {
	local dashes lhost trash_dir log_dir log_file script version
  script=$(basename "$0")
  version="4.3.25048"
  lhost="${HOSTNAME:-$(hostname)}"
	trash_dir="$HOME/.local/share/Trash"
	log_dir="$HOME/.local/share/logs"
	log_file="trash.log"
	[[ -d "$log_dir" ]] || mkdir -p "$log_dir"

	{
		printf "%s Local Trash Log:\n" "$lhost"
		printf "Date: %s \n" "$(date '+%F %R')"
		if ! dpkg -l trash-cli > /dev/null 2>&1; then
			printf "trash-cli package is not installed.\n"
		elif [[ -d "$trash_dir" ]]; then
			empty_trash
		else
			printf "\nTrash directory does not exist.\nWill be created when a file is moved to the trash.\n"
		fi
		printf "%s\n%s %s\n" "$dashes" "$script" "$version"
	} > "$log_dir/$log_file" 2>&1
	exit
}

main
