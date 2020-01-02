" $Id: .vimrc 11 2010-04-13 08:03:26Z janus $

" Syntaxhighligthing
syntax on

" PgSQL Syntax ist von mir bevorzugt
let g:sql_type_default="psql"

" guggn ;)
filetype plugin on
filetype indent on

" Tabeinstellung
set tabstop=4
set shiftwidth=4
set expandtab
set noautoindent

" schon 4 Zeilen bevor man den oberen/unteren Bildrand erreicht los scrollen
set scrolloff=4

" Statuszeile am unteren Bildschirmrand
set laststatus=2

" Inhalt Statuszeile
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [ENCODING=%{(&fenc!=''?&fenc:&enc)}]\ [FILETYPE=%Y]\ [CHAR=%03.3b\|%02.2B]\ [POS=%04l,%04v]\ [LEN=%L]

" Darstellung fuer dunklen Hintergrund optimieren
set background=dark

set showmatch matchtime=3

" Anzeigen des Endes des zu ändernden Textes
set cpo+=$

" F2 setzen paste On/Off
set nopaste
map <F2> :set paste!<CR><BAR>:echo 'Paste Check: ' . strpart('OffOn', 3 * &paste, 3)<CR>

" STRG+U konvertiert das vorherige Wort in Grossbuchstaben
map! <C-U> <Esc>gUiw`]a

" Zeilennummerierung sowie list-zeichen ein/ausschalten
map <silent> <F10> :set number!<CR><BAR>:echo 'Number Check: ' . strpart('OffOn', 3 * &number, 3)<CR>
map! <silent> <F10> <ESC>:set number!<CR><BAR>:echo 'Number Check: ' . strpart('OffOn', 3 * &number, 3)<CR>a
set number

map <silent> <F9> :set list!<CR>
map! <silent> <F9> <ESC>:set list!<CR>a
set list
set listchars=tab:>\ ,trail:<
" funktioniert nicht ueberall -.-
"set listchars=tab:»\ ,trail:«

" aktuelles Suchwort hervorheben
set hlsearch
map <silent> <F11> :set hlsearch!<CR><BAR>:echo 'HLsearch Check: ' . strpart('OffOn', 3 * &hlsearch, 3)<CR>

" Syntax für VCards
au BufNewFile,BufRead *.vcf             setf vcard

" Syntax für ICalendar
autocmd! BufRead,BufNewFile *.ics       setfiletype icalendar

" PHP-Manual als Helpfile
autocmd BufNewFile,Bufread *.php,*.php3,*.php4,*.php5 set keywordprg="help"

" Python-Manual als Helpfile
autocmd BufNewFile,Bufread *.py set keywordprg="help"


" Userkommando zum Loeschen von Leerzeichen am Ende einer Zeile
command! Delspacesateol :%s/[[:blank:]]\+$//

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
	echo a:cmdline
	let expanded_cmdline = a:cmdline
	for part in split(a:cmdline, ' ')
		if part[0] =~ '\v[%#<]'
			let expanded_part = fnameescape(expand(part))
			let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
		endif
	endfor
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	call setline(1, 'You entered:    ' . a:cmdline)
	call setline(2, 'Expanded Form:  ' .expanded_cmdline)
	call setline(3,substitute(getline(2),'.','=','g'))
	execute '$read !'. expanded_cmdline
	setlocal nomodifiable
	1
endfunction

" Mit Strg-H alle Umlaute im markierten Bereich Html-kodieren
"function HtmlEscape()
"	silent s/ö/\&ouml;/eg
"	silent s/ä/\&auml;/eg
"	silent s/ü/\&uuml;/eg
"	silent s/Ö/\&Ouml;/eg
"	silent s/Ä/\&Auml;/eg
"	silent s/Ü/\&Uuml;/eg
"	silent s/ß/\&szlig;/eg
"endfunction
map <silent> <c-h> :call HtmlEscape()<CR>


