#!/usr/bin/env bash
###############################################################################
# Script Name  : dimmer.sh
# Description  : night-mode option to dim monitors
# Dependencies : none
# Arguments    : $1 = new brightness level $2 = night (to set dim for night-mode)
# Author       : Copyright © 2024, Richard B. Romig, Mosfanet
# Email        : rick.romig@gmail.com | rick.romig@mymetronet.com
# Created      : 27 Oct 2024
# Last updated : 27 Oct 2024, version 1.0.24301
# Comments     : based on script by Bread on Penguins, 24 Oct 2024
#              : https://www.youtube.com/watch?v=5KhJLJdk0GY
#              : Run from crontab, examples below.
#              : Works with multiple monitors.
#              : Recommend using Redshift, but this will work.
###############################################################################
#
# Copyright © 2024, Richard B. Romig
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
# License      : GNU General Public License, version 2.0

# cron jobs to execute script
# 0 6 * * * /home/rick/.local/bin/dimmer 9
# 0 17 * * * /home/rick/.local/bin/dimmer 8
# 0 18 * * * /home/rick/.local/bin/dimmer 7 night
# 0 19 * * * /home/rick/.local/bin/dimmer 6 night
# 0 20 * * * /home/rick/.local/bin/dimmer 5 night
###############################################################################

# Necessary to use as a CRON job.
export DISPLAY=:0

# Extract monitor ID's into an array.
mapfile -t monitors < <(xrandr | awk '/ connected/ {print $1}')

# Day and night settings. xrandr sets brightness 0.1 - 1.0
[[ "$1" = 10 ]] && percent="1" || percent="0.$1"
[[ "$2" = night ]] && gamma="1.0:0.95:0.85" || gamma="1.0:1.0:1.0"

for mon in "${monitors[@]}"; do
	xrandr --output "$mon" --brightness "$percent" --gamma "$gamma"
done

notify-send -t 3000 "Dimmer" "Brightness adjusted"
