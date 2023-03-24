nnoremap <F8> :call Run()<CR>
vnoremap <F8> :call Run()<CR>
inoremap <F8> :call Run()<CR>

nnoremap <F9> :call Compile()<CR>
vnoremap <F9> :call Compile()<CR>
inoremap <F9> :call Compile()<CR>

nnoremap <F10> :call Compile_And_Run()<CR>
vnoremap <F10> :call Compile_And_Run()<CR>
inoremap <F10> :call Compile_And_Run()<CR>

function Compile()
  let extension = expand('%:e')

  if extension == 'tex'
    echo "Compiling with pdflatex " . expand("%")
    !pdflatex %
  elseif extension == 'c' || extension == 'h'
    echo "Compiling with gcc " . expand("%:p")
    echo system("gcc -O2 -pipe -march=native -mtune=native -Wall -std=c90 -lm " . expand("%:p") . " -o " . expand("%:p:r") . ".out")
    echo "Done"
  elseif extension == 'cpp' || extension == 'c++' || extension == 'hpp'
    echo "Compiling with c++ " . expand("%:p")
    echo system("c++ -O2 -pipe -march=native -mtune=native -Wall -std=c++20 " . expand("%:p") . " -o " . expand("%:p:r") . ".out")
    echo "Done"
  elseif extension == 'rs'
    echo "Compiling with cargo"
    echo system("cargo build")
  endif

  unlet extension
endfunction

function Run()
  let extension = expand('%:e')

  if extension == 'tex'
    echo "Opening " . expand("%:p:h") . "/" . expand("%:r") . ".pdf"
    echo system("zathura " . expand("%:p:h") . "/" . expand("%:r") . ".pdf" . " &")
  elseif extension == 'py'
    echo "Running with python " . expand("%:p")
    echo system("python3 " . expand("%:p") . " &")
  elseif extension == 'c' || extension == 'h'
    echo "Running with c " . expand(expand("%:p:r") . ".out")
    echo system(expand("%:p:r") . ".out")
  elseif extension == 'cpp' || extension == 'c++' || extension == 'hpp'
    echo "Running with c++ " . expand(expand("%:p:r") . ".out")
    echo system(expand("%:p:r") . ".out")
  elseif extension == 'rs'
    echo "Running with cargo"
    echo system("cargo run")
  else
    echo system(expand("%:p"))
  endif

  unlet extension
endfunction

function Compile_And_Run()
  call Compile()
  call Run()
endfunction
