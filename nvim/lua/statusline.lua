local function get_command_output(command)
    local output = vim.fn.system(command .. " 2> /dev/null | tr -d '\n'")
    if output ~= "" then
        return output
    else
        return ""
    end
end

function GenerateStatusline()
    local truncate_left = "%<"
    local file_path = "%f"
    local file_info = "%h%m%r%y"
    local separator = "%="
    local time = "%{strftime('%Y-%m-%d %H:%M:%S')}"
    local line_number = "%l:%v"
    local space = " "
    local margin = "   "
    local git_branch = get_command_output("git branch --show-current")
    local git_commit = "{" .. get_command_output("git rev-parse HEAD") .. "}"
    local git_message = '"' .. get_command_output("git log -1 --pretty=%B") .. '"'
    local git_commit_time = "["
        .. get_command_output([[git log -1 --format="%cd" --date=format:"%Y-%m-%d %H:%M:%S"]])
        .. "]"
    return table.concat({
        file_path,
        space,
        file_info,
        space,
        line_number,
        margin,
        separator,
        time,
        space,
        separator,
        git_commit_time,
        space,
        git_branch,
        space,
        git_message,
        truncate_left,
    })
end

-- vim.o.cmdheight = 0
-- vim.o.laststatus = 0
vim.cmd("highlight StatusLine guibg=NONE ctermbg=NONE")
vim.cmd("highlight Command guibg=NONE ctermbg=NONE")

vim.o.statusline = GenerateStatusline()
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        vim.o.statusline = GenerateStatusline()
        vim.cmd("highlight StatusLine guibg=NONE ctermbg=NONE")
        vim.cmd("highlight Command guibg=NONE ctermbg=NONE")
    end,
})

function HideStatusline()
    vim.o.laststatus = 0
end
function ShowStatusline()
    vim.o.laststatus = 2
end
function ToggleStatusline()
    if vim.o.laststatus == 0 then
        ShowStatusline()
    else
        HideStatusline()
    end
end

-- vim.api.nvim_create_autocmd({ "CursorMoved" }, {
--     callback = function()
--         vim.o.laststatus = 0
--     end,
-- })
vim.keymap.set("n", "<leader>i", ToggleStatusline, { noremap = true, silent = true })
