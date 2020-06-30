if command -v sxiv >/dev/null 2>&1; then
    sxiv -t "$@"
else
    sxiv    "$@"
fi
