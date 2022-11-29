#!/bin/bash

# This is a simple script to setup a somewhat usable nvim on a debian based distro 
# that uses CoC as a completion tool
#
# This is based on the video provided in this url: https://www.youtube.com/watch?v=JWReY93Vl6g&t=8s&ab_channel=NeuralNine
#
# Last update: 2022-11-16

echo -e "\e[0;32mUpdating packages... \e[0m"
sudo apt update 

echo -e "\n\e[0;32mInstalling 'curl', 'wget' \e[0m"
sudo apt install curl wget git -y

echo -e "\n\e[0;32mInstalling NVM \e[0m"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

source ~/.bashrc

echo -e "\n\e[0;32mInstalling NodeJs LTS... \e[0m"
NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;
nvm install --lts

source ~/.bashrc

echo -e "\n\e[0;32mInstalling python3, pip3, npm and yarn \e[0m"
sudo apt install python3 python3-pip npm -y
sudo npm install -g yarn

source ~/.bashrc

echo -e "\n\e[0;32mInstalling NeoVIM \e[0m"
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb
rm -f nvim-linux64.deb

echo -e "\n\e[0;32mConfiguring NeoVIM \e[0m"
mkdir -p ~/.config/nvim
echo -e "\n\e[0;32mInstalling VIM Plug \e[0m"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

INIT_VIM_FILE="${HOME}/.config/nvim/init.vim"
if [ -f "$INIT_VIM_FILE" ]; then
  echo -e "\n\e[0;32m'init.vim' already exists, no additional configuration will be done \e[0m"
else 
  cat > $INIT_VIM_FILE <<EOT
:set number
:set relativenumber
:set autoindent
:set tabstop=2
:set shiftwidth=2
:set smarttab
:set softtabstop=2
:set mouse=a
:set clipboard=unnamedplus
:set expandtab

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion

set encoding=UTF-8

call plug#end()

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

:colorscheme jellybeans

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
EOT
  nvim -c 'PlugInstall'
  sudo apt install exuberant-ctags -y
  yarn --cwd ${HOME}/.local/share/nvim/plugged/coc.nvim/ install
  yarn --cwd ${HOME}/.local/share/nvim/plugged/coc.nvim/ build

  # setup basic key bindings for coc auto completion
  echo 'inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"' >> $INIT_VIM_FILE
  echo 'inoremap <silent><expr> <c-space> coc#refresh()' >> $INIT_VIM_FILE
  echo 'inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"' >> $INIT_VIM_FILE
  echo 'inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"' >> $INIT_VIM_FILE
fi

echo -e "\n\e[0;32mPost script configurations instructions... \e[0m"
echo -e "\n\e[0;32mIf on wsl, please look at the link 'https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl' to be able to copy to clipboard directly from NeoVIM \e[0m"
echo -e 

