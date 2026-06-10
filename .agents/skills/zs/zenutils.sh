#!/usr/bin/env sh
# Usage: bash .agents/skills/zs/zenutils.sh <folder/page>
# Example: bash .agents/skills/zs/zenutils.sh ZenExpansion/NullishOperators
curl -sL "https://raw.githubusercontent.com/wiki/friendlyhj/ZenUtils/$1.md"
