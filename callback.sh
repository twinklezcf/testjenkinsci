#!/bin/bash
# Configure: Tuleap server URL
mytuleap="https://infbjvm315.cn.oracle.com"
# Configure: id of your repository
repo_id=jenkinsci
# Configure: paste the token generated in repository admin
token="171c5ed4724389649bba7efe082e37ade354c6c13561614cd566a1eff3447979"

# Configure: add your own tests instead of 'make all'
# following is the test to send either "Success" (S) or "Failure" (F) to
# Tuleap server
if make all; then
    status="S"
else
    status="F"
fi

# REST call, you shouldn't need to modify this
rev=$(git rev-parse HEAD)
branch="${GIT_BRANCH#*/}"
curl "$mytuleap/api/git/$repo_id/build_status" \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json' \
     --data-binary "{ \"status\": \"$status\", \"branch\": \"$branch\", \"commit_reference\": \"$rev\", \"token\": \"$token\"}"