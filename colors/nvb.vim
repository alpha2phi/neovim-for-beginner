" clear cache so this reloads changes.
" useful for development
" lua package.loaded['nvb'] = nil
" lua package.loaded['nvb.theme'] = nil
" lua package.loaded['nvb.colors'] = nil
" lua package.loaded['nvb.util'] = nil
lua package.loaded['nvb.config'] = nil

lua require("config.colorscheme").setup()
