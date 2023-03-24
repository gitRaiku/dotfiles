if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	au! BufRead,BufNewFile *.mom         setfiletype mom
  au! BufRead,BufNewFile *.tex         setfiletype tex
augroup END
