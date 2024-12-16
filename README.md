# Plugin to use emenu effectively

https://qiita.com/uesseu/items/3cf513bc073bfdf7b0d4
 

# Example
If you want to use trigger key '<C-p>', you can write like this
and use auto-completion.

```
function! MenuMaker()
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
  delcommand MenuNoremap
endfunction
au VimEnter * call MenuMaker()
```
