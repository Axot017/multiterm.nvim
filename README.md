# multiterm.nvim

A lightweight Neovim plugin for managing multiple terminal instances with key bindings.

## Features

- Create and manage multiple terminal instances within Neovim
- Bind each terminal to a specific key for quick access
- Toggle terminals on/off with a simple keystroke
- Customize terminal window appearance

## Installation

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'Axot017/multiterm.nvim'
```

Then run `:PlugInstall`

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'Axot017/multiterm.nvim',
  config = function()
    require('multiterm').setup()
  end
}
```

Then run `:PackerSync`

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'Axot017/multiterm.nvim',
  opts = {}
}
```

Then run `:LazySync`

## Configuration

`multiterm.nvim` can be configured during setup:

```lua
require('multiterm').setup({
  -- Logging level (1=DEBUG, 2=INFO, 3=WARN, 4=ERROR)
  log_level = 4,

  -- Terminal-specific key mappings
  mappings = {
    -- Mode-specific mappings
    t = {
      -- Key = action or {action = action, opts = {}}
      ["<C-x>"] = "<C-\\><C-n>",
      ["<Esc>"] = {
        action = "<C-\\><C-n>",
        opts = {desc = "Exit terminal mode"}
      }
    },
    n = {
      -- Normal mode mappings for terminal buffers
      ["q"] = function() require('multiterm').close_active() end
    }
  },

  -- Window configuration (can be a table or a function that returns a table)
  window = {
    relative = "editor",
    width = 80,
    height = 20,
    style = "minimal",
    border = "rounded",
    row = 10,
    col = 10,
  }
})
```

### Default Window Configuration

By default, the plugin creates a floating window at 80% of editor size, centered on screen:

```lua
window = function()
  local default_width = math.floor(vim.o.columns * 0.8)
  local default_height = math.floor(vim.o.lines * 0.8)

  return {
    relative = "editor",
    width = default_width,
    height = default_height,
    style = "minimal",
    border = "rounded",
    row = math.floor((vim.o.lines - default_height) / 2),
    col = math.floor((vim.o.columns - default_width) / 2),
  }
end
```

## Usage

### API Functions

| Function | Description |
|----------|-------------|
| `setup(opts)` | Configure the plugin with options |
| `toggle(binding)` | Toggle terminal with specific binding |
| `bind_toggle()` | Interactively bind a key to toggle a terminal |
| `remove(binding)` | Remove terminal with specific binding |
| `bind_remove()` | Interactively select a terminal to remove |
| `remove_all()` | Remove all terminals |
| `close_active()` | Close the currently active terminal |
| `send_text(binding, text)` | Send text to a terminal with specific binding |
| `send_selection(binding)` | Send visually selected text to a terminal with specific binding |
| `bind_send_selection()` | Interactively bind a key to send visually selected text to a terminal |

### Example Keymaps

Add these to your Neovim configuration:

```lua
-- Toggle a terminal bound to key 'g'
vim.keymap.set('n', '<leader>tg', function() require('multiterm').toggle('g') end)

-- Interactively bind a key to a terminal
vim.keymap.set('n', '<leader>tb', function() require('multiterm').bind_toggle() end)

-- Remove a terminal with binding 'g'
vim.keymap.set('n', '<leader>rg', function() require('multiterm').remove('g') end)

-- Interactively remove a terminal
vim.keymap.set('n', '<leader>rb', function() require('multiterm').bind_remove() end)

-- Remove all terminals
vim.keymap.set('n', '<leader>ra', function() require('multiterm').remove_all() end)

-- Close active terminal
vim.keymap.set('n', '<leader>tc', function() require('multiterm').close_active() end)

-- Send text to a terminal with binding 'g'
vim.keymap.set('n', '<leader>sg', function() require('multiterm').send_text('g', 'echo "Hello world"\n') end)

-- Send visually selected text to a terminal with binding 'g'
vim.keymap.set('v', '<leader>sg', function() require('multiterm').send_selection('g') end)

-- Interactively choose a terminal to send visually selected text to
vim.keymap.set('v', '<leader>sb', function() require('multiterm').bind_send_selection() end)
```

### Workflow Example

1. Press `<leader>tb` to bind a terminal
2. Type a key (e.g., 'g') to associate with your terminal
3. A new terminal will open
4. Press `<leader>tg` to toggle this terminal on/off
5. Create more terminals with different bindings as needed

### Vim Commands

The plugin also provides the following Vim commands:

| Command | Description |
|---------|-------------|
| `:MultitermToggle <binding>` | Toggle terminal with specific binding |
| `:MultitermBindToggle` | Interactively bind a key to toggle a terminal |
| `:MultitermRemove <binding>` | Remove terminal with specific binding |
| `:MultitermBindRemove` | Interactively select a terminal to remove |
| `:MultitermRemoveAll` | Remove all terminals |
| `:MultitermCloseActive` | Close the currently active terminal |
| `:MultitermSendSelection <binding>` | Send visually selected text to a terminal with specific binding |
| `:MultitermBindSendSelection` | Interactively bind a key to send visually selected text to a terminal |

## Health Check

You can check the health of the plugin by running:

```
:checkhealth multiterm
```

This will verify:
- Compatible Neovim version
- Required features availability
- Proper loading of configuration and utilities

## License

MIT
