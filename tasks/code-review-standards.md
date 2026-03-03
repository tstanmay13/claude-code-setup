## Code Review Standards

- Review your own diff before presenting it
- Check for: unused imports, debug logs, hardcoded values, missing error handling
- Ensure backwards compatibility unless explicitly breaking
- Add inline comments for non-obvious logic
- Check `git diff --staged` for accidental secret inclusion
- Verify no `.env`, credentials, or tokens are in the diff
