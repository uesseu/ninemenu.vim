
function! ninemenu#busy_cmd_complete(num=1)
  for c in 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM'
    exec $"cnoremap {c} {c}{repeat(ninemenu#get_wildcharm(),a:num)}"
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

function! ninemenu#wrap_one_shot_complete(command, tabnum=1)
  return $":call ninemenu#one_shot_complete({a:tabnum})<CR>"
        \.$":{a:command} {ninemenu#get_wildcharm()}"
endfunction

function! ninemenu#comp_noremap(trigger, command, tabnum=1)
  exec $"noremap {a:trigger} {ninemenu#wrap_one_shot_complete(a:command, a:tabnum)}"
endfunction

command! -nargs=* MenuNoremap call ninemenu#comp_noremap(<f-args>)

MenuNoremap <C-p> emenu 2
MenuNoremap <C-p><C-p> emenu 2
MenuNoremap <C-p>e e
MenuNoremap <C-p>b b
MenuNoremap <C-p><C-b> b
MenuNoremap <C-p>r r
MenuNoremap <C-p><C-r> r
MenuNoremap <C-p>d b
MenuNoremap <C-p><C-d> b
MenuNoremap <C-p>c call
MenuNoremap <C-p>s set
MenuNoremap <C-p>! !
MenuNoremap <C-p>h h


exec $"noremap <C-p>: {ninemenu#wrap_one_shot_complete('')}"
