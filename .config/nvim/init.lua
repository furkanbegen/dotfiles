local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

function get_spring_boot_runner(profile, debug)
  local debug_param = ""
  if debug then
    debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

function run_spring_boot(debug)
  -- Prompt the user for the Spring profile name
  local profile_name = vim.fn.input("Enter Spring profile name: ")

  -- Check if a profile name was provided
  if profile_name ~= "" then
    -- Execute the command to start the Spring Boot application with the provided profile
    vim.cmd('tabnew | term ' .. get_spring_boot_runner(profile_name, debug))
  else
    vim.cmd('tabnew | term ' .. get_spring_boot_runner(profile_name, debug))
  end
end

vim.keymap.set("n", "<F9>", function() run_spring_boot() end)
vim.keymap.set("n", "<F10>", function() run_spring_boot(true) end)


if vim.fn.has('termguicolors') == 1 then
  vim.opt.termguicolors = true
end

