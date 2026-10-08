# gray-observe

Local turn telemetry — the *local* half of hermes' `observability/langfuse`
plugin, with no external service. Every host event becomes one JSON line in
`~/.gray/observe/<YYYY-MM-DD>.jsonl`.

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
