vim.opt.mouse = "a" -- enable mouse support
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10

vim.opt.updatetime = 50

vim.opt.shell = "fish"

vim.opt.laststatus = 3 -- Set global status line


local function set_hi_groups()
  vim.cmd([[highlight WinSeparator guibg=None]]) -- Remove borders for window separators
  vim.cmd([[highlight SignColumn guibg=None]]) -- Remove background from signs column
end
set_hi_groups()


-- Add position to jumplist if moving more than 5 lines up or down
vim.keymap.set("n", "j", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'j']], { expr = true })
vim.keymap.set("n", "k", [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'k']], { expr = true })


-- Don't auto comment new lines
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})


-- Disable some default plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "python3_provider",
  "python_provider",
  "node_provider",
  "ruby_provider",
  "perl_provider",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  -- "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end
