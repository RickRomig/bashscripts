#!/bin/bash
##########################################################################
# Script Name  : pwfeedback.sh
# Description  : Enables/disables display of asterisks when entering password on CLI.
# Dependencies : none
# Arguments    : none
# Author       : Richard B. Romig, 27 Sep 2020
# Email        : rick.romig@gmail.com
# Comments     :
##########################################################################
# Copyright (C) 2021, Richard B. Romig
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

# shellcheck disable=SC2014
# shellcheck disable=SC2034

## Variables ##

readonly SCRIPT=$(basename "$0")
readonly VERSION="1.0.1"
readonly UPDATED="04 Feb 2021"
readonly PWFB=$(sudo grep -wq 'pwfeedback' /etc/sudoers)
readonly PWFB_FILE="/etc/sudoers.d/0pwfeedback"

## Functions ##

enable_pwfeedback() {
  PWFB="$1"
  if [ -z "$PWFB" ] && [ ! -f "$PWFB_FILE" ]; then
    sudo sh -c 'echo "Defaults pwfeedback" > /etc/sudoers.d/0pwfeedback'
    sudo chmod 440 "$PWFB_FILE"
    echo "Password feedback enabled by $PWFB_FILE"
  else
    echo -n "Password feedback is already enabled by "
    [ -f "$PWFB_FILE" ] && echo "$PWFB_FILE" || echo "/etc/sudoers"
  fi
}

disable_pwfeedback() {
  PWFB="$1"
  if [ -f "$PWFB_FILE" ]; then
    sudo rm -f "$PWFB_FILE"
    echo "Password feeback is disabled. $PWFB_FILE has been deleted."
  elif [ -n "$PWFB" ]; then
    echo "Password feedback is enabled in /etc/sudoers."
    echo "Run the command 'sudo visudo' to edit the sudoers file and remove 'pwfeedback'."
  else
    echo "Password feedback is not enabled."
  fi
}

## Execution ##

sudo ls > /dev/null 2>&1
clear
echo "$SCRIPT v$VERSION (Updated: $UPDATED)"
echo -e "Enable/Disable password feedback in the terminal.\n"
OPTIONS=("Enable password feedback" "Disable password feedback" "Take no action")
PS3="Option: "
select OPT in "${OPTIONS[@]}"; do
  case "$REPLY" in
    1 ) enable_pwfeedback "$PWFB"; break ;;
    2 ) disable_pwfeedback "$PWFB"; break ;;
    3 ) echo "Exiting without making changes."; break ;;
    * ) echo -e "\e[91mInvalid choice.\e[0m Try again." ;;
  esac
done

exit
