return {
    'dgagn/diagflow.nvim',
    -- event = 'LspAttach', This is what I use personnally and it works great
    opts = {
        show_borders = true,
        padding_right = 0,
        border_chars = {
            top_left = " ",
            top_right = " ",
            bottom_left = " ",
            bottom_right = " ",
            horizontal = " ",
            vertical = " "
          },
    }
}
