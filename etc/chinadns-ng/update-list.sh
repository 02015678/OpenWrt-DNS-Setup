#!/bin/bash -e
set -o errexit
set -o pipefail

# Use CDN cached version of Github original files
# Note that ChinaDNS-NG uses plain text of gfwlist
wget https://cdn.jsdelivr.net/gh/pexcn/daily@gh-pages/chnroute/chnroute.txt -nv -O ./chnroute.txt
wget https://cdn.jsdelivr.net/gh/pexcn/daily@gh-pages/chnroute/chnroute-v6.txt -nv -O ./chnroute6.txt
wget https://cdn.jsdelivr.net/gh/pexcn/daily@gh-pages/gfwlist/gfwlist.txt -nv -O ./gfwlist.txt
wget https://cdn.jsdelivr.net/gh/pexcn/daily@gh-pages/chinalist/chinalist.txt -nv -O ./chinalist.txt

# You can add exceptions to chinalist_suffix.txt
cat /etc/chinadns-ng/chinalist_suffix.txt >> ./chinalist.txt

/etc/init.d/chinadns-ng restart
exit 0
