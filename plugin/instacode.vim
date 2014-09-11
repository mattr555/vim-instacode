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

" Ripped directly from haskellmode.vim
function! s:url_encode(string)
	let pat  = '\([^[:alnum:]]\)'
	let code = '\=printf("%%%02X",char2nr(submatch(1)))'
	let url  = substitute(a:string,pat,code,'g')
	return url
endfunction

" Open URLs with the system's default application. Works for both local and
" remote paths.
function! s:open_url(url)
	let url = shellescape(a:url)

	if has('mac')
		silent call system('open '.url)
	elseif has('unix')
		if executable('xdg-open')
			silent call system('xdg-open '.url.' 2>&1 > /dev/null &')
		else
			echoerr 'You need to install xdg-open to be able to open urls'
			return
		end
	elseif has('win32') || has('win64')
		exe '!start rundll32 url.dll,FileProtocolHandler '.url
	else
		echoerr 'Don''t know how to open a URL on this system'
		return
	end
endfunction

function! Instacode(start_lineno, end_lineno)
	let code = join(getbufline('%', a:start_lineno, a:end_lineno), "\n")
	call s:open_url('http://instacod.es/?post_code='.s:url_encode(code).'&post_lang='.&ft)
endfunction

command -range=% Instacode :call Instacode(<line1>, <line2>)
if !hasmapto("<Esc>:Instacode<CR>")
	xnoremap <leader>ic :Instacode<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
