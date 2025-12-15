# ========= global config =========
[no-cd]
default:
  @just --list --unsorted

# ========= git worktree workflow =========
# new git worktree: j wt ISSUE_123 [base]
[no-cd]
wt ISSUE BASE='master':
  git worktree add "{{ISSUE}}" "{{BASE}}" -b "{{ISSUE}}"
  cd "{{ISSUE}}" && just i

# remove git worktree: j rwt ISSUE_123
[no-cd]
rwt ISSUE:
  git worktree remove "{{ISSUE}}" --force
  git branch -D "{{ISSUE}}" 2>/dev/null || true

# ========= pnpm commands =========
# install dependencies with pnpm
[no-cd]
i:
  pnpm install

# run server with pnpm
[no-cd]
s:
  pnpm run serve

# run dev with pnpm
[no-cd]
d:
  pnpm run dev

# build project with pnpm
[no-cd]
b:
  pnpm run build

# deploy project with pnpm
[no-cd]
deploy: b
  pnpm run deploy
   
# ========= git utilities =========
# open repo in browser
[no-cd]
web:
  #!/usr/bin/env bash
  set -e
  url="https://$(git remote get-url origin | sed 's/.*@//;s/:/\//;s/.git$//')"
  echo "🔗 $url"
  explorer.exe "$url" || true

# ========= editors =========
# open with zed
[no-cd]
zed:
  zed .

# open with antigravity
[no-cd]
a:
  antigravity .

# open with cursor
[no-cd]
c:
  cursor .
