local multiterm = require("multiterm")

vim.api.nvim_create_user_command("MultitermToggle",
  function(opts)
    multiterm.toggle(opts.fargs[1])
  end, {
    nargs = 1,
  })

vim.api.nvim_create_user_command("MultitermBindToggle",
  function()
    multiterm.bind_toggle()
  end, {
    nargs = 0,
  })

vim.api.nvim_create_user_command("MultitermRemove",
  function(opts)
    multiterm.remove(opts.fargs[1])
  end, {
    nargs = 1,
  })

vim.api.nvim_create_user_command("MultitermBindRemove",
  function()
    multiterm.bind_remove()
  end, {
    nargs = 0,
  })

vim.api.nvim_create_user_command("MultitermRemoveAll",
  function()
    multiterm.remove_all()
  end, {
    nargs = 0,
  })

vim.api.nvim_create_user_command("MultitermCloseActive",
  function()
    multiterm.close_active()
  end, {
    nargs = 0,
  })

vim.api.nvim_create_user_command("MultitermSendSelection",
  function(opts)
    multiterm.send_selection(opts.fargs[1])
  end, {
    nargs = 1,
    range = true,
  })

vim.api.nvim_create_user_command("MultitermBindSendSelection",
  function()
    multiterm.bind_send_selection()
  end, {
    nargs = 0,
    range = true,
  })
