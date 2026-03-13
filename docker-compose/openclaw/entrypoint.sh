#!/bin/bash
set -e

# Start SSH daemon in background (requires root)
/usr/sbin/sshd

# Run original container command via base image entrypoint
exec docker-entrypoint.sh "$@"
