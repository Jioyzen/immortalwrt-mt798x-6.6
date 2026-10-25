#!/usr/bin/env bash
set -euo pipefail

root_dir="$(git rev-parse --show-toplevel)"
cd "$root_dir"

./scripts/feeds update -a

declare -A feed_commits=(
	[packages]=27a0f631a93f63bff9865526a9b4a74a10ca82f5
	[luci]=7f9ad99d611a7548125e73b7e375b6d1793ca1ef
	[routing]=00619bc7bc60d8b67ecc490121e45298b122cd6e
	[telephony]=92892fa285360b8981f62bf4e0a097e6449e7e33
)

for feed in "${!feed_commits[@]}"; do
	feed_dir="feeds/$feed"
	commit="${feed_commits[$feed]}"
	if ! git -C "$feed_dir" cat-file -e "$commit^{commit}" 2>/dev/null; then
		git -C "$feed_dir" fetch --quiet origin "$commit"
	fi
	git -C "$feed_dir" checkout --quiet --detach "$commit"
done

./scripts/feeds install -a
