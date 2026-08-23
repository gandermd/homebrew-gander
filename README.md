# gandermd/gander

Homebrew tap for [gander](https://github.com/gandermd/gander-cli) — a CLI
that renders Markdown in your browser.

```bash
brew tap gandermd/gander
brew install gander
```

## Maintenance

This tap tracks `gandermd/gander-cli` releases. When a new release is
published, the maintainer runs `scripts/bump-homebrew.sh <version>` from
the gander-cli checkout; that script invokes `brew bump-formula-pr`,
which fetches fresh SHA256s straight from the GitHub release assets and
opens a PR here.

PRs are validated by `.github/workflows/audit.yml`, which runs
`brew audit --strict --new --tap=gandermd/gander gander` on every change.

## Layout

| File                       | Purpose                                            |
| -------------------------- | -------------------------------------------------- |
| `Formula/gander.rb`        | Single multi-arch formula (macOS + Linux × arm64 + amd64) |
| `LICENSE`                  | MIT                                                |
| `.github/workflows/audit.yml` | `brew audit --strict` on every PR              |