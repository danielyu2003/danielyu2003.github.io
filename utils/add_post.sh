#!/bin/sh

HELPMSG="usage: ./add_post"
DATE=$(date '+%Y-%m-%d')

if [ $# != 0 ]; then
	echo $HELPMSG
	exit 1
fi

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create the new directory in the right location
POST_DIR="$SCRIPT_DIR/../content/archive/$DATE"
mkdir -p "$POST_DIR"

# Change to the new directory and create index.md
cd "$POST_DIR"

touch index.md
cat << EOF > index.md
+++
title = "tmp"
date = $DATE
authors = ["Daniel Yu"]
[extra]
footer = "Liked this post? Feel free to leave a comment below!"
+++

insert summary

<!-- more -->

insert rest of content

EOF

echo "created index.md at content/archive/$DATE"
