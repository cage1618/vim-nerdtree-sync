if exists("g:loaded_nerdtree_sync") || &cp
  finish
endif

let g:loaded_nerdtree_sync = 4  " plugin version
let s:keepcpo = &cpo
set cpo&vim

function! s:isNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! s:syncTree()
  if &modifiable && s:isNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff && bufname('%') !~# 'NERD_tree'
    try
      NERDTreeFind
      if bufname('%') =~# 'NERD_tree'
        setlocal nocursorline
        wincmd p
      endif
    endtry
  endif
endfunction

autocmd BufEnter * silent! call s:syncTree()

let &cpo = s:keepcpo
unlet s:keepcpo
