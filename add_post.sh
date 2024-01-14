#!/bin/sh

# Note to future me: Don't move this script!

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
footer = "Liked this post? Feel free to leave a comment <a href='https://github.com/danielyu2003/danielyu2003.github.io/discussions'>here</a>!"
+++

insert summary

<!-- more -->

insert rest of content

EOF

echo created index.md at content/archive/$DATE
