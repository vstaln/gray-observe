<div align="center">
  <img alt="gray-observe" src="assets/icon.svg" width="120" height="120" />
  <h1>gray-observe</h1>
  <p><strong>Local turn telemetry as JSON lines, with no external service.</strong></p>
  <p>
    <a href="https://gray.alignment.id">Website</a> ·
    <a href="https://gray.alignment.id/plugins/gray-observe">Store</a> ·
    <a href="https://github.com/vstaln/gray-observe">Source</a> ·
    <a href="https://github.com/vstaln/gray">gray</a>
  </p>
  <p>
    <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-1c1c20?style=flat-square&labelColor=0a0a0b" /></a>
    <a href="https://www.rust-lang.org"><img alt="Built with Rust" src="https://img.shields.io/badge/built%20with-rust-1c1c20?style=flat-square&labelColor=0a0a0b&logo=rust&logoColor=d4a373" /></a>
    <a href="https://gray.alignment.id/plugins/gray-observe"><img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-1c1c20?style=flat-square&labelColor=0a0a0b&color=7aa2f7" /></a>
  </p>
</div>

<br/>

```bash
gray plugin install gray-observe
```

Local turn telemetry with no external service. Every host event becomes one
JSON line in `~/.gray/observe/<YYYY-MM-DD>.jsonl`.

A sidecar plugin for [gray](https://github.com/vstaln/gray), scaffolded by
[gray-account](https://github.com/vstaln/gray-account).

## What gets logged

| event        | record |
|--------------|--------|
| `pre_tool`   | `{type, ts, session, tool, args_len}` |
| `post_tool`  | `{type, ts, session, tool, is_error, content_len}` |
| `turn_end`   | `{type, ts, session, usage}` |

Only lengths and names are recorded — never argument or result content.
A day's file rotates to `<date>.jsonl.1` when it would pass 10 MB.

## Usage

```text
/observe            # today's turns, tool calls, top tools, error rate
/observe tail 20    # last 20 raw JSONL lines (default 10)
```

## Install

```sh
gray plugin install observe
```

## Wire methods

- `plugin/manifest` — declares `/observe`
- `event/notify` — `pre_tool` / `post_tool` / `turn_end` notifications
  (broadcast to every loaded plugin; no hooks needed)
- `command/run` — `/observe` stats and `tail`
- `plugin/shutdown`

No `host/*` capabilities.

## Develop

```sh
cargo test
gray account check      # entry point + manifest handshake
gray account publish    # check → build → release → publish to the gray registry
```

Bump `version` in `Cargo.toml` before each `publish`; the registry refuses to
republish a version.

## Tags

`gray` `plugin` `observe` `rust`

---

Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
