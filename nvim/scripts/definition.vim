nnoremap <F4> "9yiw:call Print_Def()<CR>
vnoremap <F4> "9y:call Print_Def()<CR>
inoremap <F4> <esc>"9yiw:call Print_Def()<CR>

function Print_Def()
 echo system("dict " . @9)
endfunction
