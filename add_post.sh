#!/bin/sh

HELPMSG="Usage: ./add_post"
DATE=$(date '+%Y-%m-%d')

if [ $# != 0 ]; then
	echo $HELPMSG
	exit 1
fi

mkdir content/archive/$DATE
cd content/archive/$DATE
touch index.md
cat << EOF > index.md
+++
title = "tmp"
date = $DATE
[extra]
footer = "Feel free to leave comments or requests <a href='https://github.com/danielyu2003/danielyu2003.github.io/discussions'>on the discussions page</a>!"
+++

insert summary

<!-- more -->

insert rest of content

EOF

echo created index.md at content/archive/$DATE
