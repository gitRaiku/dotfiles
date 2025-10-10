vnoremap <Leader>/ <esc>:call CommentSelection()<CR>

function CommentSelection()
 let [s:line_start, s:column_start] = getpos("'<")[1:2]
 let [s:line_end, s:column_end] = getpos("'>")[1:2]
   
endfunction
