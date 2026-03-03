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
- Proactively compact when context feels heavy — don't wait until you're forced to
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
- Run tests, check logs, demonstrate correctness

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

### Orchestrator Rules
- The orchestrator NEVER reads raw test output — that eats context
- Always delegate test runs to the implementer or reviewer subagent
- Only receive summaries: pass/fail count, failure descriptions, files affected

### Builder-Validator Pattern
- The **implementer** builds the feature AND runs tests — if tests fail, it fixes them before reporting back
- The **reviewer** independently verifies — it runs the test suite separately without trusting the implementer's claim that "it works"
- If both agree it passes, it passes. If the reviewer finds issues, the orchestrator sends the implementer back to fix

### Testing Requirements
- Unit tests: run on every change, implementer handles this
- Integration tests: run before any PR, reviewer verifies independently
- E2E tests: for user-facing features, don't trust unit tests alone — actually verify the feature works end-to-end
- Bug fixes: write a regression test that FAILS first, then fix the bug, then verify the test passes

### What the Orchestrator Gets Back
- From implementer: "Changed 3 files, added 2 tests, 47/47 pass"
- From reviewer: "Verified independently. 47/47 pass. Found 1 issue: missing null check in auth handler line 42"
- The orchestrator makes decisions based on these summaries, never raw logs

### Never Mark Done Without
- Implementer confirms tests pass
- Reviewer independently confirms tests pass
- For UI changes: visual verification (screenshot or browser check)
- For API changes: actual request/response verification
- git diff reviewed for unintended changes

## Code Review Standards

- Review your own diff before presenting it
- Check for: unused imports, debug logs, hardcoded values, missing error handling
- Ensure backwards compatibility unless explicitly breaking
- Add inline comments for non-obvious logic
