
" Color self
syn keyword Keyword self

" Color % format in string
syn match pythonStrFormatting   "%\%(([^)]\+)\)\=[-#0 +]*\d*\%(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
syn match pythonStrFormatting   "%[-#0 +]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]" contained containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
