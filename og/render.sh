#!/bin/sh
# Renders og/og.html into docs/og.png (1200×630) with headless Chrome, using the fonts embedded in docs/index.html.
set -eu
cd "$(dirname "$0")/.."
tmp=$(mktemp -d)
trap 'rm -rf "$tmp" 2>/dev/null || true' EXIT

python3 - "$tmp/og.html" <<'EOF'
import re, sys
fonts = '\n'.join(re.findall(r'@font-face\{[^}]*\}', open('docs/index.html', encoding='utf-8').read()))
page = open('og/og.html', encoding='utf-8').read().replace('/*FONTS*/', fonts)
open(sys.argv[1], 'w', encoding='utf-8').write(page)
EOF

# A throwaway profile keeps the user's own Chrome profile out of it. With one, Chrome writes the screenshot but
# does not exit, so wait for the file and then stop that Chrome.
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --user-data-dir="$tmp/profile" \
  --use-mock-keychain --hide-scrollbars --force-device-scale-factor=1 --window-size=1200,630 \
  --virtual-time-budget=3000 --screenshot="$tmp/og.png" "file://$tmp/og.html" >/dev/null 2>&1 &
chrome=$!
i=0
while [ ! -s "$tmp/og.png" ] && [ $i -lt 60 ]; do sleep 1; i=$((i + 1)); done
sleep 1
kill $chrome 2>/dev/null || true
wait $chrome 2>/dev/null || true

[ -s "$tmp/og.png" ] || { echo "Chrome did not render og.png" >&2; exit 1; }
mv "$tmp/og.png" docs/og.png
echo "docs/og.png rendered"
