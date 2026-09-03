#!/bin/sh
set -e

# Persistent state lives on the NFS volume at /data so it can be edited on the
# host. Symlink each path into /app where the bot reads and writes it.
mkdir -p /data/.minecraft-auth

for f in \
  guildsConfig.json \
  adminRolesConfig.json \
  linkedAccountsConfig.json \
  linkRoleConfig.json \
  globalProfileConfig.json \
  auditChannelConfig.json \
  featureRequestsConfig.json \
  .env
do
  rm -f "/app/$f"
  ln -sfn "/data/$f" "/app/$f"
done

rm -rf /app/.minecraft-auth
ln -sfn /data/.minecraft-auth /app/.minecraft-auth

exec "$@"
