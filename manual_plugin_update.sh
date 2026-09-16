#!/usr/bin/env bash

set -euo pipefail

plugin_path="$(nvim --headless --clean -l <(echo 'print(vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"))') 2>&1)" && readonly plugin_path

shopt -s nullglob

for dir in "$plugin_path"/*; do
  plugin_name="${dir#"${plugin_path}"/}"
  echo "Updating $plugin_name. . ."
  retry_time=1
  while ! git -C "${dir}" pull
  do
    if (( $(bc <<< "$retry_time > 60") ))
    then
      echo "Failed to pull ${plugin_name}; continuing" 1>&2
      continue 2
    fi

    echo "Failed to pull ${plugin_name}; waiting ${retry_time} seconds and trying again" 1>&2
    sleep "$retry_time"
    retry_time=$(echo "scale=4; $retry_time * ((1 + sqrt(5)) / 2)" | bc -l)
  done
  retry_time=1
  while ! git -C "${dir}" submodule update --init --recursive
  do
    if (( $(bc <<< "$retry_time > 60") ))
    then
      echo "Failed to submodule update ${plugin_name}; continuing" 1>&2
      continue 2
    fi

    echo "Failed to submodule update ${plugin_name}; waiting ${retry_time} seconds and trying again" 1>&2
    sleep "$retry_time"
    retry_time=$(echo "scale=4; $retry_time * ((1 + sqrt(5)) / 2)" | bc -l)
  done
done
