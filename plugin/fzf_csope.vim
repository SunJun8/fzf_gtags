""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim using popup and preview window
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains fzf shortcut for vim's cscope interface,
" with keyboard mappings.
" Prerequiites
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Nabendu Maiti       nbmaiti83@gmail.com     2021/3/14
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'

  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi',
  \             '--prompt',
  \             '> ',
  \             '--multi',
  \             '--bind',
  \             'alt-a:select-all,alt-d:deselect-all',
  \             '--color',
  \             'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'window': {'width': 0.9, 'height': 0.6}
  \ }

  " let g:preview = ['right:50%']
  " let preview_opts = call('fzf#vim#with_preview', g:preview).options
  " call extend(opts.options, preview_opts)

  function! opts.sink(lines)
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction

  call fzf#run(fzf#wrap(opts))
endfunction

function! CscopeQuery(option)
  call inputsave()
  if a:option == '0'
      let query = input('C Symbol: ')
  elseif a:option == '1'
      let query = input('Definition: ')
  elseif a:option == '2'
      let query = input('Functions calling: ')
  elseif a:option == '3'
      let query = input('Functions called by: ')
  elseif a:option == '4'
      let query = input('Text: ')
  elseif a:option == '6'
      let query = input('Egrep: ')
  elseif a:option == '7'
      let query = input('File: ')
  elseif a:option == '8'
      let query = input('Files #including: ')
  elseif a:option == '9'
      let query = input('Assignments to: ')
  else
      echo "Invalid option!"
      return
  endif
  call inputrestore()
  if query != ""
    call Cscope(a:option, query)
  else
    echom "Cancelled Search!"
  endif
endfunction

" default and permanent key apping
nnoremap <silent> <Leader>ks :call Cscope('0', expand('<cword>'))<CR>
nnoremap <silent> <Leader>kg :call Cscope('1', expand('<cword>'))<CR>
nnoremap <silent> <Leader>kd :call Cscope('2', expand('<cword>'))<CR>
nnoremap <silent> <Leader>kc :call Cscope('3', expand('<cword>'))<CR>
nnoremap <silent> <Leader>kt :call Cscope('4', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ke :call Cscope('6', expand('<cword>'))<CR>
nnoremap <silent> <Leader>kf :call Cscope('7', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ki :call Cscope('8', expand('<cword>'))<CR>
nnoremap <silent> <Leader>ka :call Cscope('9', expand('<cword>'))<CR>

nnoremap <silent> <Leader>Ks :call CscopeQuery('0')<CR>
nnoremap <silent> <Leader>Kg :call CscopeQuery('1')<CR>
nnoremap <silent> <Leader>Kd :call CscopeQuery('2')<CR>
nnoremap <silent> <Leader>Kc :call CscopeQuery('3')<CR>
nnoremap <silent> <Leader>Kt :call CscopeQuery('4')<CR>
nnoremap <silent> <Leader>Ke :call CscopeQuery('6')<CR>
nnoremap <silent> <Leader>Kf :call CscopeQuery('7')<CR>
nnoremap <silent> <Leader>Ki :call CscopeQuery('8')<CR>
nnoremap <silent> <Leader>Ka :call CscopeQuery('9')<CR>

