# laud machine-local config. Lives at ${XDG_CONFIG_HOME:-~/.config}/laud/config.zsh, not in the repo.
# Sourced by bin/laud on every run. Everything is optional; unset means stock Claude Code behaviour.

# Command prefix that launches Claude Code; laud appends all claude args to it.
# For a wrapper that takes claude's args after a separator, include the separator.
# LAUD_CMD=(claude)
# LAUD_CMD=(my-wrapper claude --)

# Base built-in tools; +groups add to these. Drop a built-in you replace with an MCP tool.
# WebSearch is an Anthropic server-side tool and may not work through other API providers or
# gateways; drop it there and add a search MCP server via LAUD_MCP.
# LAUD_TOOLS=(Bash Read Write Edit WebSearch WebFetch)

# MCP configs (files or JSON strings); with --strict-mcp-config these are the only servers
# (unless +mcp). Tool names are mcp__<server>__<tool>, so a subagent whose definition names
# one only works if a config here defines a server with that exact name.
# LAUD_MCP=(~/.claude/my-fetch-mcp.json)

# Default claude args, placed before yours (yours win on conflict).
# LAUD_ARGS=(--model opus)
