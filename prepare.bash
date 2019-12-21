#!/usr/bin/env bash

set -e

rm -rf html
agda --html --html-highlight=auto other/index.agda
