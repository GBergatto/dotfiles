local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

local configs = require("nvim-treesitter.configs")
configs.setup {
    ensure_installed = "all",
    sync_install = false, 
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,

    },
    indent = { enable = true, disable = { "yaml" } },
    -- p00f/nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    }
}


