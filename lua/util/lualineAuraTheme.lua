local colors = {
    purple = "#b282ff",
    dark_bg = "#242332",
    --light_gray = "#d7d9e1",
    dim_gray = "#21202e",
    medium_gray = "#8c8c8c",
    teal = "#6affde",
    inactive_bg = "#433c67",
    inactive_fg = "#9796a5",
    muted_purple = "#706994",
}
 

return {
    command = {
        a = { bg = colors.purple, fg = colors.dark_bg, gui = "bold" },
        b = { bg = colors.dark_bg, fg = colors.purple },
        c = { bg = colors.dim_gray, fg = colors.purple}
    },
    inactive = {
        a = { bg = colors.inactive_bg, fg = colors.inactive_fg, gui = "bold" },
        b = { bg = colors.dark_bg, fg = colors.muted_purple },
        c = { bg = colors.dim_gray, fg = colors.muted_purple}
    },
    insert = {
        a = { bg = colors.teal, fg = colors.dark_bg, gui = "bold" },
        b = { bg = colors.dark_bg, fg = colors.teal },
        c = { bg = colors.dim_gray, fg = colors.teal }
    },
    normal = {
        a = { bg = colors.inactive_bg, fg = colors.inactive_fg, gui = "bold" },
        b = { bg = colors.dark_bg, fg = colors.muted_purple },
        c = { bg = colors.dim_gray, fg = colors.muted_purple}

    },
    replace = {
        a = { bg = colors.teal, fg = colors.dark_bg, gui = "bold" },
        b = { bg = colors.dark_bg, fg = colors.teal },
        c = { bg = colors.dim_gray, fg = colors.teal}
    },
    terminal = {
        a = { bg = colors.purple, fg = colors.dark_bg, gui = "bold" },
        b = { bg = colors.dark_bg, fg = colors.purple },
        c = { bg = colors.dim_gray, fg = colors.purple}

    },
    visual = {
        a = { bg = colors.purple, fg = colors.dark_bg, gui = "bold" },
        b = { bg = colors.dark_bg, fg = colors.purple },
        c = { bg = colors.dim_gray, fg = colors.purple}
    }
}
