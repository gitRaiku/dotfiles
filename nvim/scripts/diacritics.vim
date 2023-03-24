nnoremap <C-m> :call Change_Diacritics()<CR>
" inoremap <C-m> :call Change_Diacritics()<CR>i

function Change_Diacritics()
  let chdict = {'a': 'ă', 'ă': 'â', 'â': 'a', 'i': 'î', 'î': 'i', 's': 'ş', 'ş': 's', 't': 'ţ', 'ţ': 't', 'A': 'Ă', 'Ă': 'Â', 'Â': 'A', 'I': 'Î', 'Î': 'I', 'S': 'Ş', 'Ş': 'S', 'T': 'Ţ', 'Ţ': 'T'}
  let char = matchstr(getline('.'), '.', col('.')-1) 
  let destchar = get(chdict, char, char)
  exe "normal r" . destchar
  echo destchar
endfunction
