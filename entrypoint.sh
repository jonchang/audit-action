#!/bin/sh -l

echo "::group::Update Homebrew"
brew update
brew install-bundler-gems
git fetch --unshallow
echo "::endgroup::"

start_sha=$(git rev-parse origin/$GITHUB_BASE_REF)
end_sha=$GITHUB_SHA

cat <<EOS
Testing with:
  diff_start_sha1 $start_sha
  diff_end_sha1   $end_sha
EOS

new_formulae=$(git diff-tree -r --name-only --diff-filter=A $start_sha $end_sha -- Formula/)
modified_formulae=$(git diff-tree -r --name-only --diff-filter=M $start_sha $end_sha -- Formula/)

cat <<EOS
Formula to be audited:
  added formulae    $new_formulae
  modified formulae $modified_formulae
EOS

cp /brew-audit.json .
echo "::add-matcher::brew-audit.json"
rm brew-audit.json

[ ! -z "$new_formulae" ] && brew audit --display-filename --new-formula --online $new_formulae
[ ! -z "$modified_formulae" ] && brew audit --display-filename --online $modified_formulae

echo "::remove-matcher owner=brew-audit::"
