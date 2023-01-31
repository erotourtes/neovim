local loaded, gitsigns = pcall(require, "gitsigns")
if not loaded then print("Gitsigns is not loaded") return end

vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<cr>")
vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<cr>")
vim.keymap.set("n", "<leader>gn", ":Gitsigns next_hunk<cr>zz")
vim.keymap.set("n", "<leader>gp", ":Gitsigns prev_hunk<cr>zz")

local icons = require("ui.icons").ui

local options = {
  signs = {
    add = {
      hl = "GitSignsAdd",
      text = icons.block,
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn",
    },
    change = {
      hl = "GitSignsChange",
      text = icons.block,
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = icons.triangle,
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = icons.triangle,
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = icons.block,
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  yadm = { enable = false },}

gitsigns.setup(options)
