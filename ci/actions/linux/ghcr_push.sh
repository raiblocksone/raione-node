#!/bin/bash
set -e

scripts="$PWD/ci"
if [[ "$GITHUB_WORKFLOW" = "Develop Branch Dockers Deploy" ]]; then
    "$scripts"/custom-timeout.sh 30 docker push "ghcr.io/${GITHUB_REPOSITORY}/raione-env:base"
    "$scripts"/custom-timeout.sh 30 docker push "ghcr.io/${GITHUB_REPOSITORY}/raione-env:gcc"
    "$scripts"/custom-timeout.sh 30 docker push "ghcr.io/${GITHUB_REPOSITORY}/raione-env:clang"
    "$scripts"/custom-timeout.sh 30 docker push "ghcr.io/${GITHUB_REPOSITORY}/raione-env:rhel"
else
    tags=$(docker images --format '{{.Repository}}:{{.Tag }}' | grep "ghcr.io" | grep -vE "env|none")
    for a in $tags; do
        "$scripts"/custom-timeout.sh 30 docker push "$a"
    done
fi
