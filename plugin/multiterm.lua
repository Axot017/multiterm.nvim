local multiterm = require("multiterm")

vim.api.nvim_create_user_command("MultitermToggle",
  function(opts)
    multiterm.toggle(opts.fargs[1])
  end, {
    nargs = 1,
  })
