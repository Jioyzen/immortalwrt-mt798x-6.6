# Qihoo 360T7 clean build profile

Based on `openwrt-24.10-6.6`, target profile `qihoo_360t7`, Linux 6.6.

Includes the MTK SDK MT7981 Wi-Fi driver and calibration path, `mtwifi-cfg` with its LuCI page, MTK HNAT/WARP and the MTK TurboACC/eQoS LuCI pages. Core LuCI, firewall, PPPoE and IPv6 support remain enabled.

Proxy clients and proxy LuCI apps are excluded. The Mediatek platform default package set is reduced for this fork: optional WireGuard, TTYD, nftables TProxy, Btrfs and USB tethering tools are no longer forced into the common rootfs. USB host support and core firewall/NAT packages remain. The TurboACC LuCI package dependencies are narrowed to MTK HNAT, BBR and full-cone NAT; generic accelerator dependencies unrelated to this board are removed.

Build with:

```sh
cp defconfig/qihoo-360t7-clean.config .config
make defconfig
make -j4
```
