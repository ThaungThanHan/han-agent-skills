#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
destination="$HOME/.agents/skills"
skills=()

usage() {
  cat <<'EOF'
Usage: ./install.sh [--dest DIRECTORY] [SKILL ...]

Install all skills, or only the named skills. Existing installations are skipped.
Default destination: ~/.agents/skills

Examples:
  ./install.sh
  ./install.sh han-learn
  ./install.sh --dest /path/to/project/.agents/skills han-learn
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --dest)
      if [ "$#" -lt 2 ] || [ -z "$2" ] || [[ "$2" == -* ]]; then
        echo "Error: --dest requires a directory." >&2
        exit 1
      fi
      destination="$2"
      shift 2
      ;;
    -*)
      echo "Error: unknown option '$1'. Use --help for usage." >&2
      exit 1
      ;;
    *)
      skills+=("$1")
      shift
      ;;
  esac
done

if [ "${#skills[@]}" -eq 0 ]; then
  for skill_dir in "$repo_dir"/skills/*; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    skills+=("${skill_dir##*/}")
  done
fi

if [ "${#skills[@]}" -eq 0 ]; then
  echo "Error: no skills found in $repo_dir/skills." >&2
  exit 1
fi

# Validate every selection before creating or copying anything.
for skill in "${skills[@]}"; do
  if [[ ! "$skill" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || [ ! -f "$repo_dir/skills/$skill/SKILL.md" ]; then
    echo "Error: unknown skill '$skill'. See README.md for available skills." >&2
    exit 1
  fi
done

mkdir -p -- "$destination"
for skill in "${skills[@]}"; do
  target="$destination/$skill"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "Skipped $skill: $target already exists."
  else
    cp -R -- "$repo_dir/skills/$skill" "$target"
    echo "Installed $skill: $target"
  fi
done
