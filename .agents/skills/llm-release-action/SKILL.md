---
name: llm-release-action
description: Provides specialized context, rules, and tools for implementing, configuring, and debugging llm-release-action. Use this skill whenever modifying llm-release-action configurations or adding related functionality.
---
# llm-release-action

## File Tree

```text
llm-release-action/
├── assets
├── modules
│   └── llm-release-action (https://github.com/nosovj/llm-release-action)
├── references
├── scripts
└── SKILL.md
```

> **Agent Instructions:** The `modules/` directory contains full source code repositories. Probe is configured for this workspace. Use Probe MCP tools to inspect and search code dynamically across target folder paths instead of raw static AST dumps:
> - `probe search "<query>" [path]` - Search code semantically with Elasticsearch-style syntax.
> - `probe extract <file>:<line>` - Extract complete AST semantic blocks.
> - `probe query "<pattern>"` - Perform AST structural pattern matching.
> - `probe symbols <file>` - List code symbols (functions, classes, constants) in target file.