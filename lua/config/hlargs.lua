local M = {}

function M.setup()
  require("hlargs").setup {
    color = "#ef9062",
    use_colorpalette = false,
    -- highlight = { "TSParameter" },
    colorpalette = {
      { fg = "#ef9062" },
      { fg = "#3AC6BE" },
      { fg = "#35D27F" },
      { fg = "#EB75D6" },
      { fg = "#E5D180" },
      { fg = "#8997F5" },
      { fg = "#D49DA5" },
      { fg = "#7FEC35" },
      { fg = "#F6B223" },
      { fg = "#F67C1B" },
      { fg = "#DE9A4E" },
      { fg = "#BBEA87" },
      { fg = "#EEF06D" },
      { fg = "#8FB272" },
    },
    excluded_filetypes = { "lua", "rust", "typescript", "typescriptreact", "javascript", "javascriptreact" },
  }
end

return M
