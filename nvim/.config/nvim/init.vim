" TODO: CREATE ORDER IN THIS MESS

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'https://github.com/vim-scripts/restore_view.vim'
Plug 'https://github.com/jrudess/vim-foldtext'
Plug 'https://github.com/windwp/nvim-autopairs'
Plug 'https://github.com/p00f/nvim-ts-rainbow'

" https://github.com/mg979/vim-visual-multi
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" tree-sitter needs nightly version:
"   https://github.com/neovim/neovim/releases
"   Need to figure out how to get this onto remote machines lol
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

" Theme
Plug 'navarasu/onedark.nvim'

" Discord presence
Plug 'andweeb/presence.nvim'

" Neorg + plenary for some dependancies for Neorg
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
" Don't forget to do :PlugInstall

" Discord presence settings because I'm dumb
let g:presence_neovim_image_text = "No. I don't know why I use it either."
let g:presence_buttons = 0
lua << EOF
    require('nvim-treesitter.configs').setup {
    ensure_installed = {"c", 
                        "comment", 
                        "cpp", 
                        "css",
                        "html", 
                        "java",
                        "javascript",
                        "latex",
                        "lua",
                        "markdown",
                        "norg",
                        "python",
                        "vim"
                        },
        highlight = { enable = true },
        rainbow = { enable = true },
    }

    require('nvim-autopairs').setup {
        map_cr = true,
    }

    require('neorg').setup {
        load = {
            ["core.defaults"] = {},
            ["core.norg.concealer"] = {},
        }
    }
    
    require('onedark').setup {
        style = 'darker',
        highlights = {
            -- Make it so that matched parens are readable
            MatchParen = {fg = '$fg', bg = '$grey'},
        }
    }
    require('onedark').load()

    require'lspconfig'.texlab.setup{}
EOF

colorscheme onedark

" KEY REMAPPINGS

" Escape leaves terminal mode
:tnoremap <esc> <C-\><C-n>

" noh - remove highlight when pressing <esc> after search
:nnoremap <esc><esc> :noh <return>

" PLUGIN SETTINGS

" Visual Multi settings from the tutorial
let g:VM_mouse_mappings = 1
let g:VM_theme = 'iceblue'
let g:VM_maps = {}
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'

" Fold settings
" Settings for vim-foldtext
:highlight Folded cterm=bold ctermfg=LightCyan ctermbg=NONE
set viewoptions=cursor,folds,slash,unix
" TODO: Figure out better fold settings
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" restore_view settings
" Ignore .vim files for restore_view
let g:skipview_files = ['*\.vim']
" Get rid of line numbers
let g:FoldText_info = 0

" GENERAL SETTINGS

" Set yank and paste use the same clipboard as the whole of the machine
" needs xclip
set clipboard+=unnamedplus

" auto reload files when changes occur outside
set autoread

" Indent settings
set autoindent
filetype plugin indent on
" General tab settings
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" I think these are drop down menu / autocomplete menu settings?
:highlight Pmenu ctermbg=DarkGray
:highlight PmenuSel ctermfg=White ctermbg=DarkMagenta

" Open splits the right way
:set splitright
:set splitbelow

" custom terminal open commands
:command Hterm :split  | :terminal
:command Vterm :vsplit | :terminal

" search settings
set ignorecase
set smartcase
set incsearch
