local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup {
    options = {
        numbers = "buffer_id",
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        show_close_icon = false,
        show_buffer_close_icons = false,
        indicator = {
            -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
            -- style = 'underline'
        },
        max_name_length = 12
    },

    highlights = {
        buffer_selected = {
            bg = '#483d8b', bold = true
        },
        close_button_selected = {
            bg = '#483d8b'
        },
        numbers_selected = {
            bg = '#483d8b', bold = true, italic = true
        },
        indicator_selected = {
            bg = '#483d8b'

        }
    },
}
