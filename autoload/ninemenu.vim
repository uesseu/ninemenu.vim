scriptencoding utf-8
" ninemenu.vim
" Last Change:	2024 Dec 16
" Maintainer:	Shoichiro Nakanishi <sheepwing@kyudai.jp>
" License:	Mit licence

if exists('g:loaded_ninemenu')
  finish
endif
let g:loaded_ninemenu = 1

let s:save_cpo = &cpo
set cpo&vim

function! ninemenu#busy_cmd_complete(num=1)
  for c in '1234567890.qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM'
    exec $"cnoremap {c} {c}{repeat(ninemenu#get_wildcharm(),a:num)}"
    exec $"cnoremap `{c} {c}"
  endfor
endfunction

function! ninemenu#get_wildcharm()
  return split(trim(execute('set wildchar?')), '=')[1]
endfunction

function! ninemenu#one_shot_complete(tabnum=1)
  exec "set wildmode=full:longest,full"
  exec "au CmdlineLeave * cmapclear" 
  exec $"au CmdlineLeave * ++once set {trim(execute('set wildmode?'))}" 
  exec $"call ninemenu#busy_cmd_complete({a:tabnum})"
endfunction

function! ninemenu#wrap_one_command(command, tabnum=1)
  return $":call ninemenu#one_shot_complete({a:tabnum})<CR>"
        \.$":{a:command} {ninemenu#get_wildcharm()}"
endfunction

function! ninemenu#wrap_ongoing_command(command, tabnum=1)
  return $":call ninemenu#one_shot_complete({a:tabnum})<CR>"
        \.$":{a:command}{ninemenu#get_wildcharm()}"
endfunction

function! ninemenu#comp_noremap(trigger, command, tabnum=1)
  exec $"noremap {a:trigger} {ninemenu#wrap_one_command(a:command, a:tabnum)}"
endfunction

"command! -nargs=* MenuNoremap call ninemenu#comp_noremap(<f-args>)


let &cpo = s:save_cpo
unlet s:save_cpo
