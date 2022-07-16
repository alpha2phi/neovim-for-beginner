#!/usr/bin/sh

NVIM_BEGINNER=~/.config/nvim-beginner
export NVIM_BEGINNER

# Neovide
alias nvbg='XDG_DATA_HOME=$NVIM_BEGINNER/share XDG_CACHE_HOME=$NVIM_BEGINNER XDG_CONFIG_HOME=$NVIM_BEGINNER nohup neovide &'

# Neovim Qt
# alias nvbg='XDG_DATA_HOME=$NVIM_BEGINNER/share XDG_CACHE_HOME=$NVIM_BEGINNER XDG_CONFIG_HOME=$NVIM_BEGINNER nohup nvim-qt &'

# Goneovim
# alias nvbg='XDG_DATA_HOME=$NVIM_BEGINNER/share XDG_CACHE_HOME=$NVIM_BEGINNER XDG_CONFIG_HOME=$NVIM_BEGINNER nohup goneovim &'

nvbg
