#!/bin/bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo "Usage: decomp-mixin.sh <class_path>" >&2
    echo "Example: decomp-mixin.sh .mixin.out/class/path/to/TargetClass.class" >&2
    exit 1
fi

if ! command -v java &>/dev/null; then
    echo "Error: java command not found" >&2
    exit 1
fi

if [[ ! -f "cfr-0.152.jar" ]]; then
    echo "Error: cfr-0.152.jar not found in current directory" >&2
    exit 1
fi

f="$1"

if [[ ! -f "$f" ]]; then
    echo "Error: File not found: $f" >&2
    exit 1
fi

if [[ ! -r "$f" ]]; then
    echo "Error: Cannot read file: $f" >&2
    exit 1
fi

output_dir="${f%/*}"
java_file=$(find "$output_dir" -name "*.java" -newer "$f" 2>/dev/null | head -1)

if [[ -z "$java_file" ]]; then
    echo "Decompiling: $f"
    if ! java -jar cfr-0.152.jar "$f" --outputdir "$output_dir" --clobber true; then
        echo "Error: Decompilation failed" >&2
        exit 1
    fi
    java_file=$(find "$output_dir" -name "*.java" -mmin -1 2>/dev/null | head -1 || true)
fi

if [[ -z "$java_file" || ! -f "$java_file" ]]; then
    echo "Error: No .java file found after decompilation" >&2
    exit 1
fi

cat "$java_file"