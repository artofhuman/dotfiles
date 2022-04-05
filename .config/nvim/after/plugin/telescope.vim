lua << EOF
    -- You dont need to set any of these options. These are the default ones. Only
    -- the loading is important
    local actions = require('telescope.actions')
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"]   = actions.move_selection_next,
            ["<C-k>"]   = actions.move_selection_previous,
            ["<C-q>"]   = actions.smart_send_to_qflist + actions.open_qflist,
            ["<ESC>"]   = actions.close,
            }
          }
        }
      }

    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    require('telescope').load_extension('fzf')
EOF

" Find files using Telescope command-line sugaras.
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <C-i> <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>r <cmd>lua require('telescope.builtin').lsp_references()<cr>
