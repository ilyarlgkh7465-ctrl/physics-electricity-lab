#!/bin/bash
# Собирает готовую страницу index.html из src/index.html (src — тело страницы без <html>/<head>).
set -euo pipefail
cd "$(dirname "$0")"
{ printf '<!doctype html>\n<html lang="ru">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  # всё до первого <div class="wrap"> (title, шрифты, стили) уходит в <head>
  sed '/<div class="wrap">/,$d' src/index.html | grep -v 'claude:viewport'
  printf '<meta name="description" content="Интерактивные опыты по физике: сопротивление металлов и температура, диэлектрик в электрическом поле">\n'
  printf '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n</head>\n<body>\n'
  sed -n '/<div class="wrap">/,$p' src/index.html
  printf '</body>\n</html>\n'; } > index.html
echo "index.html собран"
