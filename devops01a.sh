#!/usr/bin/env bash
 
echo "number of volumes, size of each volume, free space on each volume"
df -h | sed 's/Avail/Free/'
sudo lvmdiskscan
echo "        "

echo "number cpus/cores, information about the cpus/core"
 lscpu | grep CPU
lscpu | grep Core | grep -v CPU
echo "        "

echo "amount of ram"
free -h | awk '/^Mem/ {print "Total memory is",$2}' 
free -h | awk '/^Mem/ {print "In use memory is",$3}' 	      
free -h | awk '/^Mem/ {print "free memory is",$4}'
echo "       "

echo "mac address(s) and ip address(s)"
ip a | awk 'function outline() {if (link>"") {printf "%s %s %s\n", iface, inets, link}} \
$0 ~ /^[1-9]/ {outline(); iface=substr($2, 1, index($2,":")-1); inets=""; link=""} $1 \
== "link/ether" {link=$2} $1 == "inet" {inet=substr($2, 1, index($2,"/")-1); if (inets>"") \
inets=inets ","; inets=inets inet} END {outline()}'
