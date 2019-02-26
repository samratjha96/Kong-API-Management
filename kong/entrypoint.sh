#!/bin/sh
set -e

/bin/containerpilot kong start --run-migrations

sleep 20

# Register API
curl -i -X POST --url http://localhost:8001/apis/  \
    --data 'name=Jokes' \
    --data 'uris=/joke' \
    --data 'hosts=joke.com' \
    --data 'upstream_url=https://geek-jokes.sameerkumar.website/api'

# Add plugin
curl -i -X POST --url http://localhost:8001/apis/Jokes/plugins/  \
    --data "name=key-auth"

# Create user
curl -i -X POST --url http://localhost:8001/consumers/ --data "username=Samrat"

# Create keys for Jason
curl -i -X POST http://kong:8001/consumers/Samrat/key-auth -d 'key=samrat_secret_key'

# Run this after
# curl -iL -X GET  --url http://localhost:8000/joke   --header 'Host: joke.com' --header "apikey: samrat_secret_key"

tail -f /dev/null
