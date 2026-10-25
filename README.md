# ImmortalWrt 360T7 固件

本仓库基于 [padavanonly/immortalwrt-mt798x-6.6](https://github.com/padavanonly/immortalwrt-mt798x-6.6)，为 Qihoo 360T7（MT7981 / Filogic）提供配置和构建流程。源码使用 Linux 6.6 内核与 MTK SDK 无线驱动路线。

## 固件信息

- 设备：Qihoo 360T7，目标 `mediatek/filogic`，设备配置 `qihoo_360t7`
- 无线：使用本仓库上游 MTK SDK 驱动及 360T7 适配
- 默认网络地址：`192.168.6.1`（首次启动后按需修改）
- 默认登录：`root`，无密码；首次登录后请立即设置密码
- 额外包含：MTK HNAT 驱动及 LuCI 页面、ttyd 终端和简体中文包
- 最近一次本地构建清单：403 个软件包；实际选择以构建生成的 `.manifest` 为准

构建产物位于 `bin/targets/mediatek/filogic/`，360T7 的升级镜像名称包含 `qihoo_360t7` 和 `squashfs-sysupgrade.bin`。固件使用前请核对设备型号、镜像类型，并保留可用的恢复方式。

## 本地构建

需要 Debian/Ubuntu x86_64 主机、稳定网络和充足磁盘空间。先安装常用构建依赖：

```sh
sudo apt update
sudo apt install -y build-essential clang flex bison g++ gawk gcc-multilib \
  g++-multilib gettext git libelf-dev libncurses-dev libssl-dev python3-dev \
  python3-setuptools python3-pyelftools python3-yaml rsync swig time unzip \
  wget xsltproc zlib1g-dev file
```

克隆本仓库的 `360t7-clean` 分支，锁定 feeds 并构建：

```sh
git clone --branch 360t7-clean --single-branch \
  https://github.com/Jioyzen/immortalwrt-mt798x-6.6.git
cd immortalwrt-mt798x-6.6
./scripts/update-360t7-feeds.sh
JOBS=12 ./scripts/build-360t7.sh
```

`update-360t7-feeds.sh` 会检出本地验证时使用的 feeds 提交并安装 feeds；`build-360t7.sh` 会应用 `config/360t7.config`、生成配置、下载源码并编译。可通过 `JOBS` 调整并行线程数。不传 `JOBS` 时使用主机报告的 CPU 线程数。

## GitHub Actions 云端构建

工作流文件：`.github/workflows/build-360t7.yml`。

- 推送到 `360t7-clean` 分支且修改构建相关文件时自动构建。
- 也可以在 GitHub 仓库的 **Actions → Build and release 360T7 firmware → Run workflow** 手动启动。
- 云端使用 Ubuntu 24.04 和可用 CPU 线程数，运行同一套 feeds 锁定及构建脚本。
- 成功后会上传镜像、manifest、配置、日志和 SHA256 校验文件为 Actions artifact，并创建 GitHub Release。

本仓库的本地构建已成功完成。本次云端构建仍需以 Actions 实际运行结果确认；云端磁盘、网络或 runner 环境差异仍可能导致失败。

## 构建配置

- 设备配置：[`config/360t7.config`](config/360t7.config)
- 本地构建脚本：[`scripts/build-360t7.sh`](scripts/build-360t7.sh)
- feeds 锁定脚本：[`scripts/update-360t7-feeds.sh`](scripts/update-360t7-feeds.sh)
- 云端工作流：[`.github/workflows/build-360t7.yml`](.github/workflows/build-360t7.yml)

## 上游与许可

本项目保留上游 ImmortalWrt / OpenWrt 代码与相应许可。上游 MTK SDK 源码见 [padavanonly/immortalwrt-mt798x-6.6](https://github.com/padavanonly/immortalwrt-mt798x-6.6)。
