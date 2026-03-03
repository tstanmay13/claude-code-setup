# Global Workflow Orchestration

## Workflow Orchestration

### 1. Plan Mode Default
- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately — don't keep pushing
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

### 2. Context Management
- Before compacting or when context is getting long, write current state to `tasks/context-state.md`
- The state file should capture: current objective, what's been done so far, what's left to do, key decisions made, important file paths and line numbers, and any blockers
- After compacting, immediately read `tasks/context-state.md` to restore awareness
- **Hard rule: compact at 65% context usage, don't wait longer**
- Prefer delegating investigation to subagents over reading files directly in the orchestrator
- When a subagent returns results, summarize the key findings in 2-3 sentences rather than pasting full output

### 3. Subagent Strategy
- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution

### 4. Self-Improvement Loop
- After ANY correction from the user: update `tasks/lessons.md` with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start for relevant project

### 5. Verification Before Done
- Never mark a task complete without proving it works
- Diff behavior between main and your changes when relevant
- Ask yourself: "Would a staff engineer approve this?"
- Demand EVIDENCE not confirmation — show test output, show the diff, show the API response
- If you can't demonstrate it works, it's not done

### 6. Demand Elegance (Balanced)
- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- Skip this for simple, obvious fixes — don't over-engineer
- Challenge your own work before presenting it

### 7. Autonomous Bug Fixing
- When given a bug report: just fix it. Don't ask for hand-holding
- Point at logs, errors, failing tests — then resolve them
- Zero context switching required from the user
- Go fix failing CI tests without being told how

### 8. Failure Handling & Rollback
- Commit after each meaningful step so there's always a clean rollback point
- If a subagent fails the same approach twice, STOP — escalate to the user, don't retry blindly
- If the task turns out to be fundamentally different than planned, re-enter plan mode instead of patching
- When something breaks: `git stash` or `git revert` to last known good state, then re-plan
- Never leave the repo in a broken state — if you can't fix it, revert

## Task Management

- If `tasks/` doesn't exist in the current repo, create it automatically with `todo.md`, `lessons.md`, and `context-state.md`
- **Plan First**: Write plan to `tasks/todo.md` with checkable items
- **Verify Plan**: Check in before starting implementation
- **Track Progress**: Mark items complete as you go
- **Explain Changes**: High-level summary at each step
- **Document Results**: Add review section to `tasks/todo.md`
- **Capture Lessons**: Update `tasks/lessons.md` after corrections

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Impact minimal code.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Changes should only touch what's necessary. Avoid introducing bugs.
- **Context Awareness**: Read existing code patterns before writing new ones.
- **Test Everything**: No PR without passing tests. Add tests for new behavior.
- **Small Commits**: Commit often after each completed step — keeps diffs reviewable and rollback simple.

## Security

- NEVER commit secrets, API keys, tokens, or `.env` files
- If you see credentials in code, flag it immediately and move them to environment variables
- Don't put sensitive data in commit messages, PR descriptions, or Linear comments
- Check `git diff --staged` for accidental secret inclusion before every commit

## Linear Integration

- Create a Linear issue before starting any feature work
- Comment on the Linear ticket at each major milestone for audit trail
- Link PRs to the Linear issue when creating them via `gh pr create`
- Update issue status as work progresses (In Progress → In Review → Done)
- When closing a task, add a final comment summarizing what was done

## Git Conventions

- Write clear, descriptive commit messages explaining WHY not WHAT
- One logical change per commit
- Always run tests before pushing
- Create PRs with a summary, test plan, and linked Linear issue
- Never force push to main/master

## Testing Strategy
@import tasks/testing-strategy.md

## Code Review Standards
@import tasks/code-review-standards.md
