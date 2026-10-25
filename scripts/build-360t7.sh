#!/usr/bin/env bash
set -euo pipefail

root_dir="$(git rev-parse --show-toplevel)"
jobs="${JOBS:-$(nproc)}"
target_dir="bin/targets/mediatek/filogic"

cd "$root_dir"
cp config/360t7.config .config
make defconfig
make download -j"$jobs"
make -j"$jobs"

image="$(find "$target_dir" -maxdepth 1 -type f -name '*qihoo_360t7*squashfs-sysupgrade.bin' -print -quit)"
manifest="$(find "$target_dir" -maxdepth 1 -type f -name '*qihoo_360t7*.manifest' -print -quit)"

test -n "$image" && test -s "$image"
test -n "$manifest" && test -s "$manifest"

for package in kmod-mediatek_hnat luci-app-turboacc-mtk luci-app-ttyd luci-i18n-ttyd-zh-cn ttyd; do
	grep -q "^${package} " "$manifest"
done

echo "Image: $image"
sha256sum "$image"
echo "Manifest: $manifest ($(wc -l < "$manifest") packages)"
