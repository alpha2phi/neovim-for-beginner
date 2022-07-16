#!/usr/bin/sh

NVIM_BEGINNER=~/.config/nvim-beginner
export NVIM_BEGINNER

alias nvbg='XDG_DATA_HOME=$NVIM_BEGINNER/share XDG_CACHE_HOME=$NVIM_BEGINNER XDG_CONFIG_HOME=$NVIM_BEGINNER nohup neovide &'

nvbg
