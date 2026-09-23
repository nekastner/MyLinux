" line numbers
set number
set relativenumber

" tabs
set tabstop=4
set shiftwidth=4
set noexpandtab

" shell
set shell=bash
set shellcmdflag=-ic

set exrc

" show unprintable characters
set list
set listchars=
	\tab:→\ ,
	\trail:•,
	\space:·,
	\nbsp:␣,
	\eol:↲,
	\extends:⟩,
	\precedes:⟨

" delete word left
inoremap <silent> <C-BS>	<C-w>
inoremap <silent> <C-H>		<C-w>

" delete word right
inoremap <silent> <C-Del>	<C-o>de

" backtab
inoremap <silent> <S-Tab>	<C-d>
inoremap <silent> <BackTab>	<C-d>
