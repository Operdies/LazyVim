local runCommands = {
  hush = "hush"
}

-- auto open the asyncrun window with a line height of n
local n = 5
vim.g["asyncrun_open"] = n

local function AutoRunCmd(cmd, filename)
  return "while inotifywait -q -e close_write " .. filename .. "; do " .. cmd .. " " .. filename .. "; done"
end

function AsyncRunThisFile()
  local cmd = runCommands[vim.bo.filetype]
  if not cmd then
    print("No runner registered for files of type " .. vim.bo.filetype)
    return
  end
  vim.cmd("AsyncRun " .. cmd .. " %")
end

function AsyncAutoRunThisFile()
  local cmd = runCommands[vim.bo.filetype]
  if not cmd then
    print("No runner registered for files of type " .. vim.bo.filetype)
    return
  end
  local autocmd = AutoRunCmd(cmd, "%")
  vim.cmd("AsyncRun " .. autocmd)
end
