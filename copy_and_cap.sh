#!/usr/bin/env bash
set -euo pipefail

dir="${1:-cache}"

for f in "$dir"/*; do
  [ -f "$f" ] || continue

  folder=$(dirname "$f")
  filename=$(basename "$f")

  # Split extension(s) off
  stem="${filename%%.*}"        # part before first dot
  ext="${filename#"$stem"}"     # everything from first dot onward

  # Capitalize words (underscore/space-delimited)
  newstem=$(echo "$stem" | awk -F'[_ ]' '{
    for (i=1;i<=NF;i++) {
      $i = toupper(substr($i,1,1)) substr($i,2)
    }
    OFS=FS
    print
  }')

  # Insert a literal backslash before spaces
  newstem_with_slash=${newstem// /\\ }

  newname="${newstem_with_slash}${ext}"
  newpath="$folder/$newname"

  if [[ "$f" != "$newpath" ]]; then
    echo "Copying: $f → $newpath"
    cp -n -- "$f" "$newpath"
  fi
done

