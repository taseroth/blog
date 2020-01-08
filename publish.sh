#!/usr/bin/env bash

echo "installing asciidoctor"
gem install asciidoctor

echo `hugo version`
hugo --gc --minify