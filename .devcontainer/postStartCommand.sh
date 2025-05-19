#!/usr/bin/env bash

pre-commit install

if [ ! -f ".git/hooks/commit-msg" ]; then
  gitlint install-hook
fi
