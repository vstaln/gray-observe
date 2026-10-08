<p align="center">
  <img src="assets/gray-logo.svg" alt="gray" width="96">
</p>
<h1 align="center">gray-observe</h1>
<p align="center">Local turn telemetry — one JSON line per host event, no external service.</p>
<p align="center">
  <a href="https://github.com/vstaln/gray-observe/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-7aa2f7.svg">
  <img alt="rust" src="https://img.shields.io/badge/built%20with-rust-orange.svg">
</p>

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

---

Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
