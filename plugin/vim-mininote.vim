"
" vim-mininote.vim
"
"
" pre-processing
"
if exists("g:loaded_vim_mininote")
  finish
endif
let g:loaded_vim_mininote = 1
let s:save_cpo = &cpo
set cpo&vim
"
" main
"
command! Mininote call <SID>mininoteFunc()
nnoremap <Plug>(vim-mininote) :Mininote<CR>
nmap <Leader>n <Plug>(vim-mininote)
if !exists("g:mininote_store_dir")
  let g:mininote_store_dir = expand('<sfile>:p:h:h')."/vim-mininote.txt"
endif
if !exists("g:mininote_write_cmd")
  let g:mininote_write_cmd = ":w"
endif
if !exists("g:mininote_height_denomi")
  let g:mininote_height_denomi = 3
endif
let g:mininote_window_id = 0
function! s:mininoteFunc()
  if g:mininote_window_id == 0
    call s:openMininoteFunc()
  elseif !win_gotoid(g:mininote_window_id)
    call s:openMininoteFunc()
  else
    call s:closeMininoteFunc()
  endif
endfunction
function! s:openMininoteFunc()
  execute ":topleft sp ".g:mininote_store_dir
  execute ":resize ".&lines/g:mininote_height_denomi
  let g:mininote_window_id = win_getid()
endfunction
function! s:closeMininoteFunc()
  execute g:mininote_write_cmd
  execute ":bdelete"
  let g:mininote_window_id = 0
endfunction
"
" post-processing
"
let &cpo = s:save_cpo
unlet s:save_cpo
