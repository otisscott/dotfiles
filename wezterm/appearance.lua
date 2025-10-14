-- ~/.config/wezterm/appearance.lua
-- Helper module for detecting system appearance

local M = {}

function M.is_dark()
  -- Check if we're running on Windows and get system theme
  if wezterm.target_triple:find('windows') then
    -- On Windows, check registry for dark mode setting
    -- This is a simplified version - you might want to use a more robust method
    local success, stdout, stderr = wezterm.run_child_process({
      'powershell.exe',
      '-Command',
      [[
        try {
          $value = Get-ItemProperty -Path "HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" -Name "AppsUseLightTheme" -ErrorAction SilentlyContinue
          if ($value -and $value.AppsUseLightTheme -eq 0) {
            Write-Output "dark"
          } else {
            Write-Output "light"
          }
        } catch {
          Write-Output "light"  -- Default to light mode if unable to determine
        }
      ]]
    })
    
    if success and stdout and stdout[1] then
      return stdout[1]:trim() == "dark"
    end
  end
  
  -- Fallback to dark mode for other platforms
  return true
end

return M