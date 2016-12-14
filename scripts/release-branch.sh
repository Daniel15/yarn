#!/bin/bash

set -ex

OLD_VERSION=$(node -p -e "require('./package.json').version")
VERSION_BASE=$(echo $OLD_VERSION | ( IFS='.' ; read a b c && echo $a.$((b + 1)) ))
VERSION="$VERSION_BASE.0-rc.1"
BRANCH="$VERSION_BASE-stable"
yarn version --new-version $VERSION
echo "$BRANCH"
git checkout -b "$BRANCH"
git push origin "$BRANCH" --follow-tags
git checkout master
yarn version --new-version preminor --no-git-tag-version
git push origin master --follow-tags
