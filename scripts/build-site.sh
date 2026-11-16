#!/usr/bin/env bash
# Builds every homework into ./_site for GitHub Pages.
# Static homeworks are copied as-is; Vite projects are built with the
# correct sub-path base (/<repo>/<folder>/).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO_NAME="${GITHUB_REPOSITORY:-replikduplik/goit-homeworks}"
REPO_NAME="${REPO_NAME#*/}"
OUT="$ROOT/_site"

STATIC=(
  js/hw-01 js/hw-02 js/hw-03 js/hw-04 js/hw-05 js/hw-06 js/hw-07 js/hw-08
  markup/hw-01 markup/hw-02 markup/hw-03 markup/hw-04 markup/hw-05 markup/hw-06
)
VITE=(
  js/hw-09 js/hw-10 react/hw-01
  team-projects/cinemania team-projects/project-1-vite
)

rm -rf "$OUT"
mkdir -p "$OUT"
cp "$ROOT/site/index.html" "$OUT/index.html"
touch "$OUT/.nojekyll"

for dir in "${STATIC[@]}"; do
  echo "::group::copy $dir"
  mkdir -p "$OUT/$dir"
  cp -R "$ROOT/$dir/." "$OUT/$dir/"
  rm -rf "$OUT/$dir/.github" "$OUT/$dir/README.md"
  echo "::endgroup::"
done

for dir in "${VITE[@]}"; do
  echo "::group::build $dir"
  (
    cd "$ROOT/$dir"
    npm ci --no-audit --no-fund
    npx vite build --base="/$REPO_NAME/$dir/" --outDir "$OUT/$dir" --emptyOutDir
  )
  echo "::endgroup::"
done

echo "Site built in $OUT"
