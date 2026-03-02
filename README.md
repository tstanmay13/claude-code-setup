# Claude Code Setup

Global Claude Code configuration — workflow orchestration, permissions, agents, and task templates.

## Quick Install

```bash
git clone git@github.com:YOUR_USER/claude-code-setup.git
cd claude-code-setup
bash setup.sh
```

## What Gets Installed

**Globally (`~/.claude/`)** — applies to every Claude Code session:

- `CLAUDE.md` — Workflow rules: plan mode, context management, subagent strategy, self-improvement loop, verification, elegance, autonomous bug fixing, task management, Linear integration, git conventions, code review standards
- `settings.json` — Permission allowlists/denylists and hooks (auto-format, notifications)
- `agents/` — Explorer (read-only investigation), Implementer (scoped execution), Reviewer (code review)

**Per-repo (copy manually):**

- `tasks/todo.md` — Task tracking template
- `tasks/lessons.md` — Self-improvement loop log
- `tasks/context-state.md` — State dump for context compaction

## Per-Repo Setup

Copy the task templates into any project:

```bash
cp -r tasks your-repo/tasks
```

## Updating

Edit files in this repo, push, then re-run on each machine:

```bash
git pull
bash setup.sh
```

## Optional

Add a plan-mode alias to your shell:

```bash
echo "alias cc='claude --permission-mode plan'" >> ~/.zshrc
```
