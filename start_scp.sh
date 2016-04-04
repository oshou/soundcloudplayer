#/bin/sh
set -e
bundle exec unicorn -c unicorn.rb -D
