#!/bin/bash

pip install cheat

if ! grep -qs 'DEFAULT_CHEAT_DIR' ~/.bashrc; then
    echo 'export CHEATCOLORS=true' >> ~/.bashrc
    echo "export DEFAULT_CHEAT_DIR='${PWD}/.cheat'" >> ~/.bashrc
    echo "# add more cheat paths" >> ~/.bashrc
    echo '# export CHEATPATH="$CHEATPATH:/path/to/more/cheats"' >> ~/.bashrc
fi
