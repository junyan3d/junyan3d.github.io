#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
export GEM_HOME="$PWD/vendor/bundle"
export GEM_PATH="$PWD/vendor/bundle"
exec ruby vendor/bundle/gems/bundler-2.4.22/exe/bundle exec jekyll serve --host 127.0.0.1 --port 4000 --force_polling "$@"
