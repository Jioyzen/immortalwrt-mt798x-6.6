# 360T7 build

This branch keeps the upstream `padavanonly/immortalwrt-mt798x-6.6` source and adds a reproducible Qihoo 360T7 configuration.

## Local build

Install the OpenWrt build dependencies for the host, then run:

```sh
./scripts/update-360t7-feeds.sh
JOBS=12 ./scripts/build-360t7.sh
```

The sysupgrade image and package manifest are written under `bin/targets/mediatek/filogic/`. The script checks that HNAT, its LuCI page, ttyd, and its Simplified Chinese translation are included.

## GitHub Actions

Push changes to `360t7-clean` to run the same build on GitHub Actions, or start `Build and release 360T7 firmware` from the Actions tab. Successful runs publish the image, package manifest, build config, package count, and SHA256 checksums as both a workflow artifact and a GitHub release.

The feed update script checks out the same package, LuCI, routing, and telephony feed revisions used for the verified local build.

The HNAT page is `luci-app-turboacc-mtk`; its upstream package metadata brings additional networking modules as dependencies. `luci-app-ttyd` and `ttyd` are included in this 360T7 image configuration.
