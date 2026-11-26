-- Match Kitty's Option+arrow shortcuts without changing Option for other keys.
rex.bind("alt+left", "com.superlogical.terminal.write", { data = "\27b" })
rex.bind("alt+right", "com.superlogical.terminal.write", { data = "\27f" })

-- Use Rex's own light and dark theme selections.
rex.bind("ctrl+cmd+t", "client.appearance.switch_mode", { mode = "toggle" })

-- For tiled panes, prefer the most recently focused neighbor sharing this edge.
local last_focus, focus_count = {}, 0

local function remember_focus(id)
  focus_count = focus_count + 1
  last_focus[id] = focus_count
end

local function collect_panes(node, panes)
  if node.block_id then
    panes[#panes + 1] = node
  elseif node.split then
    collect_panes(node.split.before, panes)
    collect_panes(node.split.after, panes)
  end
end

local function focus_adjacent(direction)
  local view = rex.session.view{}
  for _, window in ipairs(view and view.windows or {}) do
    if window.window_id == view.active_window_id and #window.layers == 1 then
      local layout = window.layers[1].layout
      local current = window.focused_block_id
      if not layout or not current then break end

      local panes, source = {}, nil
      collect_panes(layout, panes)
      for _, pane in ipairs(panes) do
        if pane.block_id == current then source = pane.rect; break end
      end
      if not source then break end
      remember_focus(current)

      local axis = (direction == "left" or direction == "right") and 1 or 2
      local cross = 3 - axis
      local forward = direction == "right" or direction == "down"
      local edge = source[axis] + (forward and source[axis + 2] or 0)
      local target, rank = nil, -1
      for _, pane in ipairs(panes) do
        local rect = pane.rect
        local other_edge = rect[axis] + (forward and 0 or rect[axis + 2])
        local overlap = math.min(source[cross] + source[cross + 2], rect[cross] + rect[cross + 2])
          - math.max(source[cross], rect[cross])
        local recency = last_focus[pane.block_id] or 0
        if pane.block_id ~= current and math.abs(edge - other_edge) < 1e-8
          and overlap > 1e-8 and recency > rank then
          target, rank = pane.block_id, recency
        end
      end
      if target and rex.session.focus_block{ block_id = target } then
        remember_focus(target)
        return true
      end
      break
    end
  end
  return rex.session.focus_direction{ direction = direction, wrap = false } ~= nil
end

-- Also used by Emacs when it reaches the edge of its own windows.
rex.action{
  name = "focus_adjacent",
  title = "Focus Adjacent Pane",
  args = {
    type = "object",
    required = { "direction" },
    properties = { direction = { type = "string", enum = { "left", "right", "up", "down" } } },
  },
  run = function(_, args)
    return focus_adjacent(args.direction)
  end,
}

-- Keep the original key in editors and nested tmux sessions.
local function focus_pane(direction)
  return function()
    local process = rex.block.call("com.superlogical.terminal", "process", {})
    local foreground = process and process.foreground
    local name = foreground and foreground.name:lower() or ""
    if name:find("emacs", 1, true) or name:find("vim", 1, true) or name:find("tmux", 1, true) then
      return false
    end
    return focus_adjacent(direction)
  end
end

-- Match by physical key so pane navigation works in any keyboard layout.
rex.bind("ctrl+[KeyH]", focus_pane("left"))
rex.bind("ctrl+[KeyJ]", focus_pane("down"))
rex.bind("ctrl+[KeyK]", focus_pane("up"))
rex.bind("ctrl+[KeyL]", focus_pane("right"))
rex.bind("ctrl+space", "pane.zoom")

-- Toggle the floating pane with Cmd+J instead of Option+Cmd+M.
rex.unbind("cmd+alt+m")
rex.bind("cmd+j", "pane.minimize_floating")

-- Use a physical Ctrl+A prefix for all tmux-style shortcuts.
rex.bind("ctrl+[KeyA]>shift+[Backslash]", "pane.split", { direction = "right" })
rex.bind("ctrl+[KeyA]>-", "pane.split", { direction = "down" })
rex.bind("ctrl+[KeyA]>[BracketLeft]", "pane.copy_mode.enter")
rex.bind("ctrl+[KeyA]>ctrl+[KeyA]", "pane.send_key", { key = "ctrl+a" })
