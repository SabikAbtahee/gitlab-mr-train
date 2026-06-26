# Homebrew distribution

## Quick install (no tap)

```bash
brew install https://raw.githubusercontent.com/SabikAbtahee/gitlab-mr-train/main/Formula/gitlab-mr-train.rb
```

On first install, Homebrew may ask you to trust the formula:

```bash
brew trust --formula sabikabtahee/gitlab-mr-train/gitlab-mr-train
```

## Tap install (recommended for teams)

Tap the repo directly (formula lives in `Formula/`):

```bash
brew tap SabikAbtahee/gitlab-mr-train https://github.com/SabikAbtahee/gitlab-mr-train.git
brew trust sabikabtahee/gitlab-mr-train
brew install gitlab-mr-train
brew upgrade gitlab-mr-train   # later updates
```

## Cutting a release

1. Tag and push:

```bash
git tag v1.0.4
git push origin v1.0.4
```

2. Update `url` and `sha256` in `Formula/gitlab-mr-train.rb`:

```bash
curl -L https://github.com/SabikAbtahee/gitlab-mr-train/archive/refs/tags/v1.0.4.tar.gz | shasum -a 256
```

3. Commit the updated formula to `main` and push.

## Cost

Public GitHub repo + releases are free. No npm org or paid registry required.

## Prerequisites for users

- Node.js 20+ (installed by formula via `node@20`)
- git
- [glab](https://gitlab.com/gitlab-org/cli) authenticated against their GitLab instance

```bash
brew install glab
glab auth login
gitlab-mr-train init
gitlab-mr-train
```
