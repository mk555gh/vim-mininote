"
" vim-mininote.vim
"

"
" pre-process
"
if exists("g:loaded_vim_mininote")
  finish
endif
let g:loaded_vim_mininote = 1
let s:save_cpo = &cpo
set cpo&vim

"
" variable
"
if !exists("g:mininote_store_path")
  let g:mininote_store_path = expand('<sfile>:p:h:h')."/vim-mininote.txt"
endif
if !exists("g:mininote_write_cmd")
  let g:mininote_write_cmd = ":w"
endif
if !exists("g:mininote_window_height")
  let g:mininote_window_height = &lines/4
endif

"
" function
"
let g:mininote_window_id = 0
function! s:mininoteToggleFunc()
  if g:mininote_window_id == 0
    call s:openMininoteFunc()
  elseif !win_gotoid(g:mininote_window_id)
    call s:openMininoteFunc()
  else
    call s:closeMininoteFunc()
  endif
endfunction
function! s:openMininoteFunc()
  execute ":topleft sp ".g:mininote_store_path
  execute ":resize ".g:mininote_window_height
  let g:mininote_window_id = win_getid()
endfunction
function! s:closeMininoteFunc()
  execute g:mininote_write_cmd
  execute ":bwipeout"
  let g:mininote_window_id = 0
endfunction

"
" command, map
"
command! Mininote call <SID>mininoteToggleFunc()
nnoremap <Plug>(mininote-toggle) :call <SID>mininoteToggleFunc()<CR>

"
" post-process
"
let &cpo = s:save_cpo
unlet s:save_cpo
