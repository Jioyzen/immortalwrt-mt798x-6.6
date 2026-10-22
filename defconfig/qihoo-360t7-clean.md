# Qihoo 360T7 clean build profile

Based on `openwrt-24.10-6.6`, target profile `qihoo_360t7`, Linux 6.6.

Includes the MTK SDK MT7981 Wi-Fi driver and calibration path, `mtwifi-cfg` with its LuCI page, MTK HNAT/WARP and the MTK TurboACC/eQoS LuCI pages. Core LuCI, firewall, PPPoE and IPv6 support remain enabled.

Proxy clients and proxy LuCI apps are excluded. The per-device package exclusions drop optional Mediatek defaults such as WireGuard, TTYD, nftables TProxy, Btrfs and USB tethering utilities from this 360T7 image. The TurboACC LuCI package dependency list is narrowed to the HNAT, BBR and full-cone NAT features shown by this page; unrelated generic accelerator dependencies are not pulled in.

Build with:

```sh
cp defconfig/qihoo-360t7-clean.config .config
make defconfig
make -j4
```
