require("utils").create_keymap_group("<leader>r", "+run")

return {
  -- Create scratch buffers
  {
    "LintaoAmons/scratch.nvim",
    cmd = { "Scratch", "ScratchWithName", "ScratchOpen", "ScratchOpenFzf" },
    keys = {
      { "<leader>rn", "<cmd>Scratch<cr>", desc = "new scratch" },
      { "<leader>rN", "<cmd>ScratchWithName<cr>", desc = "new scratch (named)" },
      { "<leader>ro", "<cmd>ScratchOpen<cr>", desc = "open scratch" },
      { "<leader>rO", "<cmd>ScratchOpenFzf<cr>", desc = "open scratch (fzf)" },
    },
    opts = {
      filetypes = { "bash", "csx", "hush" },
    },
  },
  -- run http requests
  {
    "blackadress/rest.nvim",
    branch = "response_body_stored",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>rh", '<cmd>lua require("rest-nvim").run()<cr>', desc = "http request" },
      { "<leader>rH", '<cmd>lua require("rest-nvim").run(true)<cr>', desc = "http request (preview)" },
    },
    opts = true,
  },
  -- run code from file (incl. markdown code blocks)
  {
    "michaelb/sniprun",
    build = "bash install.sh",
    keys = {
      { "<leader>rs", '<cmd>lua require("sniprun").run()<cr>', desc = "run snip" },
      { "<leader>rS", '<cmd>lua require("sniprun").run("n")<cr>', desc = "run snip (file)" },
      { "<leader>rs", '<cmd>lua require("sniprun").run("v")<cr>', desc = "run snip", mode = "x" },
      { "<leader>rl", '<cmd>lua require("sniprun.live_mode").toggle()<cr>', desc = "live snip toggle" },
      { "<leader>rr", '<cmd>lua require("sniprun").reset()<cr>', desc = "reset snip" },
      { "<leader>rc", '<cmd>lua require("sniprun.display").close_all()<cr>', desc = "close snip" },
      { "<leader>rC", '<cmd>lua require("sniprun").clear_repl()<cr>', desc = "clear snip repl" },
      { "<leader>ri", '<cmd>lua require("sniprun").info()<cr>', desc = "snip info" },
    },
    opts = {
      display = {
        "TerminalWithCode",
      },
    },
  },
  {
    "MikaelElkiaer/base64.nvim",
    keys = {
      { "<leader>Bd", '<cmd>lua require("base64").decode()<cr>', desc = "base64 decode", mode = "x" },
      { "<leader>Be", '<cmd>lua require("base64").encode()<cr>', desc = "base64 encode", mode = "x" },
    },
  },
  {
    "Operdies/gwatch.nvim",
    dev = true,
    keys = {
      { "<leader>ct", '<cmd>lua require("gwatch").toggle()<cr>', desc = "Toggle Gwatch", mode = "n" },
      { "<leader>cs", '<cmd>lua require("gwatch").start()<cr>', desc = "Start Gwatch", mode = "n" },
      { "<leader>cx", '<cmd>lua require("gwatch").stop()<cr>', desc = "Stop Gwatch", mode = "n" },
      { "<leader>cc", '<cmd>lua require("gwatch").reload()<cr>', desc = "Reload Gwatch", mode = "n" },
    },
    opts = {
      -- The width of the UI window
      windowWidth = 80,
      -- Options in this block are the default independent of language
      default = {
        -- Check the output of `gwatch --help` for specific information about flags
        eventMask = "write",
        mode = "kill",
        patterns = "**",
        -- %e and %f respectively expand to the event, and the file it affected
        command = "echo %e %f",
      },
      -- Settings for a specific filetype override default settings
      lang = {
        lua = {
          patterns = "**.lua",
          callback = function()
            require("sniprun").run("n")
          end,
        },
        c = {
          patterns = "**.c",
          command = "clear; make run",
        },
        go = {
          patterns = { "**.go", "go.mod" },
          -- Not using 'go run .' because that doesn't return the actual running process PID.
          -- gwatch will be unable to kill spawned instances of the process.
          command = "clear; go build -o ./out .; ./out",
        },
        rust = {
          patterns = { "**.rs", "Cargo.toml" },
          command = "clear; cargo run",
        },
      },
    },
  },
}
