local multiterm = require("multiterm")

vim.api.nvim_create_user_command("MultitermToggle",
  function(opts)
    multiterm.toggle(opts.fargs[1])
  end, {
    nargs = 1,
  })

vim.api.nvim_create_user_command("MultitermRemoveone",
  function(opts)
    multiterm.remove(opts.fargs[1])
  end, {
    nargs = 1,
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
