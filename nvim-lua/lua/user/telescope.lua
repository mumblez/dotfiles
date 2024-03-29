local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- other options: 'ignore_case' or 'respect_case'
    }
  },
}

-- local themes = {
--   popup_list = {
--     theme = 'popup_list',
--     border = true,
--     preview = false,
--     prompt_title = false,
--     results_title = false,
--     sorting_strategy = 'ascending',
--     layout_strategy = 'center',
--     borderchars = {
--       prompt  = { '─', '│', '─', '│', '┌', '┐', '┤', '└' },
--       results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
--       preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
--     },
--   },
--   popup_extended = {
--     theme = 'popup_extended',
--     prompt_title = false,
--     results_title = false,
--     layout_strategy = 'center',
--     layout_config = {
--       width = 0.7,
--       height = 0.3,
--       mirror = true,
--       preview_cutoff = 1,
--     },
--     borderchars = {
--       prompt  = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
--       results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
--       preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
--     },
--   },
--   command_pane = {
--     theme = 'command_pane',
--     preview = false,
--     prompt_title = false,
--     results_title = false,
--     sorting_strategy = 'descending',
--     layout_strategy = 'bottom_pane',
--     layout_config = {
--       height = 13,
--       preview_cutoff = 1,
--       prompt_position = 'bottom'
--     },
--   },
--   ivy_plus = {
--     theme = 'ivy_plus',
--     preview = false,
--     prompt_title = false,
--     results_title = false,
--     layout_strategy = 'bottom_pane',
--     layout_config = {
--       height = 13,
--       preview_cutoff = 120,
--       prompt_position = 'bottom'
--     },
--     borderchars = {
--       prompt  = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
--       results = { '─', '│', '─', '│', '┌', '┬', '┴', '└' },
--       preview = { '─', '│', ' ', ' ', '─', '┐', '│', ' ' },
--     },
--   },
-- }

-- local map = vim.keymap.set
-- local telescope_builtin = require('telescope.builtin')
--
-- telescope.load_extension('fzf')
-- telescope.load_extension('dap')

-- local use_layout = function(picker, layout)
--   return function() picker(themes[layout]) end
-- end
-- local set_keymap = function(lhs, rhs)
--   map('n', lhs, rhs, { noremap = true })
-- end
--
-- set_keymap('<leader>t', use_layout(telescope_builtin.builtin, 'popup_list'))
-- set_keymap('<leader>o', use_layout(telescope_builtin.find_files, 'popup_list'))
-- set_keymap('<leader>b', use_layout(telescope_builtin.buffers, 'popup_extended'))
-- set_keymap('<leader>p', use_layout(telescope_builtin.commands, 'command_pane'))
-- set_keymap('<leader>g', use_layout(telescope_builtin.git_status, 'popup_extended'))
-- set_keymap('<leader>q', use_layout(telescope_builtin.quickfix, 'ivy_plus'))
-- set_keymap('<leader>l', use_layout(telescope_builtin.loclist, 'ivy_plus'))
-- set_keymap('<F1>',      use_layout(telescope_builtin.help_tags, 'popup_extended'))

