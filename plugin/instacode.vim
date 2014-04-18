" submit to instacod.es
" by mattr555
" License: WTFPL

if !has("python")
	finish
endif

if exists("g:loaded_instacode")
	finish
endif
let g:loaded_instacode = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:get_visual_selection()
	" Why is this not a built-in Vim script function?!
	let [lnum1, col1] = getpos("'<")[1:2]
	let [lnum2, col2] = getpos("'>")[1:2]
	let lines = getline(lnum1, lnum2)
	let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][col1 - 1:]
	return join(lines, "\n")
endfunction

function! Instacode()
	if getpos("'<")[1] > 0
python << endpython
import vim, webbrowser, urllib
code = vim.eval('s:get_visual_selection()')
filetype = vim.eval('&ft')
webbrowser.open('http://instacod.es/?post_code=' + urllib.quote_plus(code) + '&post_lang=' + urllib.quote_plus(filetype.title()))
endpython
	else 
		echomsg "You need to visually select something first"
	endif
endfunction

command Instacode :call Instacode()
vnoremap <leader>ic <Esc>:Instacode<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
