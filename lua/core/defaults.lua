vim.opt.guicursor = ""

vim.opt.mouse = "a" -- enable mouse support
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.wo.winblend = G.const.default_winblend
vim.o.pumblend = G.const.default_winblend

vim.opt.laststatus = 3 -- Set global status line

vim.opt.fillchars:append({ diff = "╱" })

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("TextYankPost", { clear = true }),
  callback = function()
    local mode = vim.api.nvim_get_mode()["mode"]

    -- Only highlight in normal mode. not in visual
    if mode == "no" then
      vim.highlight.on_yank({
        higroup = "Visual",
        timeout = 75,
      })
    end
  end,
})

local defaults_augroup = vim.api.nvim_create_augroup("defaults", {})

autocmd("BufEnter", {
  desc = "Don't auto comment new lines",
  group = defaults_augroup,
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

autocmd({ "TextChanged", "InsertLeave" }, {
  desc = "Autosave on leaving insert mode or text change",
  group = defaults_augroup,
  pattern = "*",
  callback = function()
    local modifiable = vim.bo.modifiable
    local no_buftype = vim.bo.buftype == ""

    local buf = vim.api.nvim_get_current_buf()
    local file = vim.api.nvim_buf_get_name(buf)
    local attached = file ~= ""

    if modifiable and no_buftype and attached then vim.cmd("silent update") end
  end,
})

autocmd("FileType", {
  desc = "Set shiftwidth to 2 for yaml files",
  group = defaults_augroup,
  pattern = { "*" },
  command = "set shiftwidth=2",
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

