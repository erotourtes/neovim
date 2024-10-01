local ts = vim.treesitter
local api = vim.api

-- -- Function to check if cursor is between tags
-- local function cursor_between_tags()
--   local node = ts.get_node()
--   if not node then return false end
--
--   local start_row, start_col, end_row, end_col = node:range()
--   local cursor_row, cursor_col = unpack(api.nvim_win_get_cursor(0))
--   cursor_row = cursor_row - 1 -- API uses 0-based index
--
--   return node:type() == "element"
--     and cursor_row == start_row
--     and cursor_col > start_col
--     and cursor_col < end_col
-- end
--
-- -- Function to format tags
-- local function format_tags()
--   local line = api.nvim_get_current_line()
--   local cursor = api.nvim_win_get_cursor(0)
--   local row, col = cursor[1], cursor[2]
--
--   -- Insert newline and indent
--   api.nvim_buf_set_lines(
--     0,
--     row,
--     row,
--     false,
--     { "", string.rep(" ", vim.bo.shiftwidth), "" }
--   )
--   api.nvim_win_set_cursor(0, { row + 1, vim.bo.shiftwidth })
-- end

local function cursor_between_tags()
  local line = api.nvim_get_current_line()
  local _, col = unpack(api.nvim_win_get_cursor(0))

  -- Check if we're between a pair of angle brackets
  local before = line:sub(1, col):match(">([^<]*)$")
  local after = line:sub(col + 1):match("^([^>]*)<")

  return before ~= nil and after ~= nil
end

-- Function to get the indentation of the current line
local function get_indentation(line) return line:match("^%s*") end

-- Function to format tags
local function format_tags()
  local line = api.nvim_get_current_line()
  local cursor = api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]

  -- Get the current indentation
  local indent = get_indentation(line)
  local additional_indent = string.rep(" ", vim.bo.shiftwidth)

  -- Split the line at the cursor position
  local before = line:sub(1, col)
  local after = line:sub(col + 1)

  -- Create new lines
  local new_lines = {
    before,
    indent .. additional_indent,
    indent .. after,
  }

  -- Replace the current line with the new lines
  api.nvim_buf_set_lines(0, row - 1, row, false, new_lines)

  -- Move the cursor to the indented line
  api.nvim_win_set_cursor(0, { row + 1, #indent + #additional_indent })
end

local function enter_pressed()
  if cursor_between_tags() then
    format_tags()
  else
    api.nvim_feedkeys(api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
  end
end

-- Set up autocommand
api.nvim_create_autocmd("FileType", {
  pattern = { "html", "javascriptreact", "typescriptreact" },
  callback = function()
    local buf = api.nvim_get_current_buf()
    vim.keymap.set(
      "i",
      "<CR>",
      enter_pressed,
      { noremap = true, silent = true, expr = false, buffer = buf }
    )
    -- api.nvim_buf_set_keymap(
    --   buf, -- current buffer
    --   "i", -- insert mode
    --   "<CR>", -- Enter key
    --   "v:lua.Erotourtes_Handle_enter_pressed()", -- Call the Lua function
    --   { noremap = true, silent = true, expr = false }
    -- )
  end,
})
