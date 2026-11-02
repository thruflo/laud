# laud

Small wrapper tool around [Claude Code](https://claude.com/product/claude-code) that allows you to limit and control which tools are installed, in order to reduce the initial context use. This often saves many tens of thousands of tokens, which keeps your sessions smarter for longer.

```sh
laud                      # minimal tool set
laud +code                # add Glob and Grep
laud +plan                # add AskUserQuestion
laud +master              # add sub-agent orchestration and workflows
laud +master +dry         # print the claude command instead of running it
laud +help                # all groups and settings
laud --resume abcd        # claude args pass straight through
```

## Install

```sh
git clone https://github.com/thruflo/laud
~/laud/install.sh
```

This symlinks `bin/laud` into `~/.local/bin` (an existing non-symlink there is moved to `laud.bak`) and seeds `~/.config/laud/config.zsh` from `config.example.zsh`. To update a machine, run `git pull`: the symlink means it takes effect straight away.

## Per-machine config

`~/.config/laud/config.zsh` is sourced on every run. Every setting is optional, and leaving one unset gives stock Claude Code behaviour:

| Setting | Values | Default |
|---|---|---|
| `LAUD_CMD` | launcher prefix, e.g. `(wrapper claude --)` | `(claude)` |
| `LAUD_TOOLS` | base built-in tools; `+groups` add to these | `(Bash Read Write Edit WebSearch WebFetch)` |
| `LAUD_MCP` | MCP config files or JSON strings | none |
| `LAUD_ARGS` | default claude args, placed before yours | none |

## Swapping in MCP tools and subagents

To replace a built-in tool with an MCP one, drop the built-in from `LAUD_TOOLS` and add the server's config to `LAUD_MCP`. For example, a custom web fetch:

```zsh
LAUD_TOOLS=(Bash Read Write Edit WebSearch)
LAUD_MCP=(~/.claude/my-fetch-mcp.json)
```

Subagents are not laud's concern: Claude Code loads `~/.claude/agents/*.md` in every session, laud or not. An agent whose `tools:` names an MCP tool (`mcp__<server>__<tool>`) only works when the session has a server with that exact name. Agents with no `tools:` list, such as general-purpose, use whatever the session has. So keep a custom agent on the machines that have its server, and use the same server name in `LAUD_MCP` as in your global MCP config.

Requires zsh, jq and Claude Code. Tool names (`Agent`, `ListAgents`, `Workflow`, …) track recent Claude Code versions, so keep the machines on similar versions.
