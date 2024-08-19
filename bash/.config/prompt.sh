#!/bin/bash

PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1='\[\e[92m\]\u\[\e[0m\]@\[\e[93m\]\h\[\e[0m\]:\w\[\e[95m\]${PS1_CMD1}\[\e[0m\]\$ '
