#!/usr/bin/env bash
# Syntaxprüfung der in index.html eingebetteten Skripte.
# Ergebnis am EXIT-CODE ablesen (0 = grün), nicht an der Ausgabe.
set -u
cd "$(dirname "$0")"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

python3 - "$tmp" <<'PY'
import io, re, sys, os
ziel = sys.argv[1]
s = io.open("index.html", encoding="utf-8").read()
bloecke = re.findall(r'<script(?![^>]*\bsrc=)[^>]*>(.*?)</script>', s, re.S)
assert bloecke, "keine eingebetteten Skriptbloecke gefunden – Muster pruefen"
for i, b in enumerate(bloecke):
    io.open(os.path.join(ziel, "block_%d.js" % i), "w", encoding="utf-8").write(b)
print("%d eingebettete Skriptbloecke" % len(bloecke))
PY

fehler=0
for f in "$tmp"/block_*.js; do
  if node --check "$f"; then
    echo "OK      $(basename "$f")"
  else
    echo "FEHLER  $(basename "$f")"
    fehler=1
  fi
done
exit $fehler
