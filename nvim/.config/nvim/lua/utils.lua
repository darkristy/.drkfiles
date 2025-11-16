local M = { path = {} }

function M.get_typescript_server_path(root_dir)
  local project_roots = vim.fs.find("node_modules", { path = root_dir, upward = true, limit = math.huge })
  for _, project_root in ipairs(project_roots) do
    local typescript_path = project_root .. "/typescript"
    local stat = vim.loop.fs_stat(typescript_path)
    if stat and stat.type == "directory" then return typescript_path .. "/lib" end
  end
  return ""
end

function M.insert_package_json(root_files, field, fname)
  return M.root_markers_with_field(root_files, { "package.json", "package.json5" }, field, fname)
end

--- @param root_files string[] List of root-marker files to append to.
--- @param new_names string[] Potential root-marker filenames (e.g. `{ 'package.json', 'package.json5' }`) to inspect for the given `field`.
--- @param field string Field to search for in the given `new_names` files.
--- @param fname string Full path of the current buffer name to start searching upwards from.
function M.root_markers_with_field(root_files, new_names, field, fname)
  local path = vim.fn.fnamemodify(fname, ":h")
  local found = vim.fs.find(new_names, { path = path, upward = true })

  for _, f in ipairs(found or {}) do
    -- Match the given `field`.
    for line in io.lines(f) do
      if line:find(field) then
        root_files[#root_files + 1] = vim.fs.basename(f)
        break
      end
    end
  end

  return root_files
end
local function is_mac() return vim.loop.os_uname().sysname == "Darwin" end

---@return string[]|nil
local function pick_trash_cmd()
  if is_mac() and vim.fn.executable("trash") == 1 then
    return { "trash" } -- Homebrew trash
  elseif vim.fn.executable("trash-put") == 1 then
    return { "trash-put" } -- Linux trash-cli
  elseif vim.fn.executable("gio") == 1 then
    return { "gio", "trash" } -- GNOME file manager tool
  elseif vim.fn.executable("kioclient5") == 1 then
    return { "kioclient5", "move" } -- KDE
  end
end

---@param path string absolute or relative path
---@param callback? fun(success:boolean)
function M.delete(path, callback)
  local cmd = pick_trash_cmd()
  if not cmd then
    vim.notify("No trash utility found, deleting permanently.", vim.log.levels.WARN)
    local ok, err = os.remove(path)
    if not ok then vim.notify(err or "Delete failed", vim.log.levels.ERROR) end
    if callback then callback(ok) end
    return
  end

  if cmd[1] == "kioclient5" then
    table.insert(cmd, "--")
    table.insert(cmd, path)
    table.insert(cmd, "trash:/")
  else
    table.insert(cmd, path)
  end

  vim.fn.jobstart(cmd, {
    detach = true,
    on_exit = function(_, code)
      local ok = code == 0
      if ok then
        vim.notify("Moved to Trash: " .. path, vim.log.levels.INFO)
      else
        vim.notify("Trash command failed (" .. table.concat(cmd, " ") .. ")", vim.log.levels.ERROR)
      end
      if callback then callback(ok) end
    end,
  })
end
return M
