require "hs.application"

local cmd_ctrl = {"ctrl", "cmd"}

hs.window.animationDuration = 0

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "U", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "B", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "N", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- -- DISPLAY FOCUS SWITCHING --
--
-- --One hotkey should just suffice for dual-display setups as it will naturally
-- --cycle through both.
-- --A second hotkey to reverse the direction of the focus-shift would be handy
-- --for setups with 3 or more displays.
--
-- --Bring focus to next display/screen
-- hs.hotkey.bind({"alt"}, "`", function ()
--   focusScreen(hs.window.focusedWindow():screen():next())
-- end)
--
-- --Bring focus to previous display/screen
-- hs.hotkey.bind({"alt", "shift"}, "`", function()
--   focusScreen(hs.window.focusedWindow():screen():previous())
-- end)
--
-- --Predicate that checks if a window belongs to a screen
-- function isInScreen(screen, win)
--   return win:screen() == screen
-- end
--
-- -- Brings focus to the scren by setting focus on the front-most application in it.
-- -- Also move the mouse cursor to the center of the screen. This is because
-- -- Mission Control gestures & keyboard shortcuts are anchored, oddly, on where the
-- -- mouse is focused.
-- function focusScreen(screen)
--   --Get windows within screen, ordered from front to back.
--   --If no windows exist, bring focus to desktop. Otherwise, set focus on
--   --front-most application window.
--   local windows = hs.fnutils.filter(
--       hs.window.orderedWindows(),
--       hs.fnutils.partial(isInScreen, screen))
--   local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
--   windowToFocus:focus()
--
--   -- Move mouse to center of screen
--   local pt = geometry.rectMidPoint(screen:fullFrame())
--   mouse.setAbsolutePosition(pt)
-- end
--
-- -- END DISPLAY FOCUS SWITCHING --

-- Switch focus and mouse to the next monitor
function windowInScreen(screen, win) -- Check if a window belongs to a screen
    return win:screen() == screen
end
function focusNextScreen()
    -- Get next screen (and its center point) using current mouse position
    -- local next_screen = hs.window.focusedWindow():screen():next()
    local next_screen = hs.mouse.getCurrentScreen():next()
    local center = hs.geometry.rectMidPoint(next_screen:fullFrame())

    -- Find windows within this next screen, ordered from front to back.
    windows = hs.fnutils.filter(hs.window.orderedWindows(),
                                hs.fnutils.partial(windowInScreen, next_screen))

    -- Move the mouse to the center of the other screen
    hs.mouse.setAbsolutePosition(center)

    --  Set focus on front-most application window or bring focus to desktop if
    --  no windows exists
    if #windows > 0 then
        windows[1]:focus()
    else
        hs.window.desktop():focus()
        -- In this case also do a click to activate menu bar
        hs.eventtap.leftClick(hs.mouse.getAbsolutePosition())
    end
end
hs.hotkey.bind({"alt"}, "`", focusNextScreen)

-- Application Switching

hs.hotkey.bind(cmd_ctrl, "s", function()
  hs.application.launchOrFocus("Spotify")
end)

hs.hotkey.bind(cmd_ctrl, "i", function()
  hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind(cmd_ctrl, "c", function()
  hs.application.launchOrFocus("Google Chrome")
end)
