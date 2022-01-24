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
let g:mk_note_store_dir = expand('<sfile>:p:h:h')."/vim-mininote.txt"
let g:mk_note_write_cmd = ":w"
let g:mk_note_window_id = 0
function! s:mininoteFunc()
  if g:mk_note_window_id == 0
    call s:openMininoteFunc()
  elseif !win_gotoid(g:mk_note_window_id)
    call s:openMininoteFunc()
  else
    call s:closeMininoteFunc()
  endif
endfunction
function! s:openMininoteFunc()
  let startLineNo = line("w0")
  let endLineNo = line("w$")
  let displayLineCnt = endLineNo - startLineNo
  execute ":topleft sp ".g:mk_note_store_dir
  execute ":resize ".displayLineCnt/3
  let g:mk_note_window_id = win_getid()
endfunction
function! s:closeMininoteFunc()
  execute g:mk_note_write_cmd
  execute ":bdelete"
  let g:mk_note_window_id = 0
endfunction
"
" post-processing
"
let &cpo = s:save_cpo
unlet s:save_cpo
