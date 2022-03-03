#!/usr/bin/sh

NVIM_BEGINNER=~/.config/nvim-beginner
export NVIM_BEGINNER

alias nvb='XDG_DATA_HOME=$NVIM_BEGINNER/share XDG_CACHE_HOME=$NVIM_BEGINNER XDG_CONFIG_HOME=$NVIM_BEGINNER nvim'

nvb
