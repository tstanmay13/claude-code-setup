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
- Implementer confirms tests pass with actual output
- Reviewer independently confirms tests pass with actual output
- For UI changes: visual verification (screenshot or browser check)
- For API changes: actual request/response verification
- git diff reviewed for unintended changes
