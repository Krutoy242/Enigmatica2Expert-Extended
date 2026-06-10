#!/usr/bin/env bash
# Usage: bash .agents/skills/lang/editlang.sh <file_path> <lang_key> <value>
# Example: bash .agents/skills/lang/editlang.sh resources/contenttweaker/lang/en_us.lang item.contenttweaker.coin_fakeiron.name "Iron Alloy Coin"

set -e

# Check for required parameters
if [ $# -lt 3 ]; then
    echo "Error: Missing arguments" >&2
    echo "Usage: $0 <file_path> <lang_key> <value>" >&2
    exit 1
fi

FILE_PATH="$1"
LANG_KEY="$2"
VALUE="$3"

# Validate file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File not found: $FILE_PATH" >&2
    exit 2
fi

# Check if file is a .lang file
if ! [[ "$FILE_PATH" == *.lang ]]; then
    echo "Error: Not a .lang file: $FILE_PATH" >&2
    exit 2
fi

# Check if key exists in file
if ! grep -q "^${LANG_KEY}=" "$FILE_PATH"; then
    echo "Error: Key not found in file: $LANG_KEY" >&2
    echo "Use 'git diff --color \"$FILE_PATH\"' to see changes" >&2
    exit 3
fi

# Escape % signs to %% for lang file format
ESCAPED_VALUE=$(printf '%s' "$VALUE" | sed 's/%/%%/g')

# Create temp file for atomic update
TEMP_FILE=$(mktemp)
trap 'rm -f "$TEMP_FILE"' EXIT

# Perform replacement and write to temp file
sed "s|^${LANG_KEY}=.*|${LANG_KEY}=${ESCAPED_VALUE}|" "$FILE_PATH" > "$TEMP_FILE"

# Move temp file to original
mv "$TEMP_FILE" "$FILE_PATH"

echo "Updated: $LANG_KEY"
git diff --color "$FILE_PATH"