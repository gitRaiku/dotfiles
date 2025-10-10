nnoremap <F5> :call New_Term()<CR>

function New_Term()
  let pwd = expand("%:p:h")
  echo system('st -e fish -c "cd ' . pwd . ' && fish" &')
endfunction
