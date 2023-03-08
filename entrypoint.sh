#!/bin/bash

set -e

child=-1

_term() {
  echo "Caught SIGTERM signal!"
  kill -TSTP "$child" 2>/dev/null
  kill -TERM "$child" 2>/dev/null
  wait "$child"
}

trap _term SIGTERM

cd /usr/src/app

case $1 in
  irb)
    echo "Service type is irb"
    bundle exec irb -r ./albion_server.rb
    child=$!
    wait "$child"
    ;;

  web)
    echo "Service type is web"
    bundle exec puma -p 3000 -e production -w 2 -t 8:32
    child=$!
    wait "$child"
    ;;

  sidekiq)
    echo "Run mode is rspec"
    bundle exec sidekiq -r ./albion_server.rb
    child=$!
    wait "$child"
    ;;
esac
