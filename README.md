# OpenWrt-DNS-Setup
Provide a reference set of configuration files of [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome), [ChinaDNS-NG](https://github.com/pexcn/openwrt-chinadns-ng), [SmartDNS](https://github.com/pymumu/openwrt-smartdns) for [OpenWrt](https://openwrt.org/).

## Introduction

This repository is aimed to provide a reference set of configuration files of [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome), [ChinaDNS-NG](https://github.com/pexcn/openwrt-chinadns-ng), [SmartDNS](https://github.com/pymumu/openwrt-smartdns) for [OpenWrt](https://openwrt.org/).

AdGuard Home - Front-end DNS Server, provide GUI statistics, and sufficient filter capability, served at port 53. Optional: served at 443 (8443), 853 for DOH, DOT support. Upstream DNS: ChinaDNS-NG.

ChinaDNS-NG - Guide DNS request to two groups. One is normal UDP upstream, for domestic websites. The other one is DOT/DOH upstream, for international websites. Upstream DNS: SmartDNS.

SmartDNS - Flexible DNS solution, which can bind (listen) to multiple ports with different configurations. For domestic websites, use local UDP DNS server, and only return the fastest A and/or AAAA record. For international result, only send to DOT/DOH compatible international DNS to avoid DNS poisoning and privacy leakage.

For game console, e.g. PSW, Nintendo Switch Online, you may want to make some exceptions, which is easily achieved by adding custom conf(s) file to SmartDNS. 

## Usage

* First, you need to have OpenWrt installed on your router, also you need sufficient free space.  
  (Better OpenWrt/LEDE 18.06 or later. Check availability [here](https://openwrt.org/toh/views/toh_fwdownload)).
* Install AdGuard Home, ChinaDNS-NG, SmartDNS, and their LuCI.  
  (Better to integrate them into your compiled OpenWrt firmware.)
* Download this repository, pick configuration files that you need, and adapt to your need.
* Disable DNS server provided by dnsmasq. (Disabled by edit /etc/config/dhcp.)  
   **WARNING: PORT 53 CAN BE BIND TO ONE AND ONLY ONE DNS SERVICE**

```config dnsmasq
	config dnsmasq
		# ... 
		# Append below lines at the end of this section
		option port '0'
		option noresolv '0'
```

* Some devices (e.g. Nintendo Switch) require at least two DNS server, or it will assert DNS fault. 
  Edit /etc/config/dhcp to declare DHCP broadcast DNS server.

```config dhcp 'lan'
	config dhcp 'lan'
		# ... 
		# Append below lines at the end of this section
		# Declare same DNS Server twice as workaround
		list dhcp_option '6,192.168.1.1,192.168.1.1'
```

* Default user credential for AdGuard Home is root, password.  
  Please change according to [here](https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration), or simply use your credential setting lines in your previous configuration file.
* Enable AdGuard Home, ChinaDNS-NG, SmartDNS as Startup Services. 
* Reboot your router.

## DISCLAIMER

THIS SET OF CONFIGURATION FILES IS PROVIDED "AS IS". USE IT AT YOUR OWN RISK. THERE IS NO EXPLICIT NOR IMPLICIT GUARANTEE FOR THE FITNESS FOR PARTICULAR USAGE. THE AUTHOR SHALL TAKE NO RESPONSIBILITY UNDER ANY CIRCUMSTANCES. PUBLISHED UNDER GNU GPLv3.
