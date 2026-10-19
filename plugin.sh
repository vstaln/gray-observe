#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-observe.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-observe" ;;
    *) rel="x86_64-apple-darwin/gray-observe" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-observe" ;;
    *) rel="x86_64-unknown-linux-musl/gray-observe" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-observe.exe" "$here/target/release/gray-observe" "$here/target/debug/gray-observe.exe" "$here/target/debug/gray-observe"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-observe binary not found in $here" >&2
exit 1
