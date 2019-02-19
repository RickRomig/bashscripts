#!/bin/bash
#####################################################################
# Script Name  : ipinfo.sh
# Description  : Displays IP information
# Dependencies : awk, ip, nmcli, wget
# Arguments    : None
# Author       : Richard Romig, 19 February 2019
# Email        : rick.romig@gmail.com
# Comment      :
#####################################################################

# Copyright (C) 2019, Richard B. Romig
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

# Variables
publicip=$(wget -qO- http://ipv4.icanhazip.com)
localip=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
gateway=$(ip route | awk '/default/ {print $3}')

# Display IP Information
echo -e "\nIP Information"
echo "=============="
echo "Public IP:"
echo -e "\t$publicip"
echo "Local IP:"
echo -e "\t$localip"
echo "Default Gateway:"
echo -e "\t$gateway"
echo "DNS Servers:"
/usr/bin/nmcli dev show | awk '/IP4.DNS/ {printf "\t%s\n",$2}'

exit 0

