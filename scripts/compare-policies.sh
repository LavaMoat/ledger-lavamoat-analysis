yarn policy:bad
yarn policy:good

cat ./lavamoat/good/policy.json | jq '.resources["@ledgerhq/connect-kit"].globals' > ./lavamoat/good/only-package-globals.json
cat ./lavamoat/bad/policy.json | jq '.resources["bad-ledgerhq-connect-kit-v1-1-7"].globals' > ./lavamoat/bad/only-package-globals.json

diff ./lavamoat/good/only-package-globals.json ./lavamoat/bad/only-package-globals.json > ./lavamoat/only-package-globals.diff