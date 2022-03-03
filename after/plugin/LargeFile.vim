" LargeFile: Sets up an autocmd to make editing large files work with celerity
"   Author:		Charles E. Campbell
"   Date:		Jan 25, 2017
"   Version:	7d	ASTRO-ONLY
"   Copyright:	see :help LargeFile-copyright
" GetLatestVimScripts: 1506 1 :AutoInstall: LargeFile.vim
"DechoRemOn

" ---------------------------------------------------------------------
" Load Once: {{{1
if exists("g:loaded_LargeFile") || &cp
 finish
endif
let g:loaded_LargeFile = "v7d"
let s:keepcpo          = &cpo
set cpo&vim

" ---------------------------------------------------------------------
" Commands: {{{1
com! Unlarge			call s:Unlarge()
com! -bang Large		call s:LargeFile(<bang>0,expand("%"))

" ---------------------------------------------------------------------
"  Options: {{{1
if !exists("g:LargeFile")
 let g:LargeFile= 20	" in megabytes
endif

" ---------------------------------------------------------------------
"  LargeFile Autocmd: {{{1
" for large files: turns undo, syntax highlighting, undo off etc
" (based on vimtip#611)
augroup LargeFile
 au!
 au BufReadPre	* call <SID>LargeFile(0,expand("<afile>"))
 au BufReadPost	* call <SID>LargeFilePost()
augroup END

" ---------------------------------------------------------------------
" s:LargeFile: {{{2
fun! s:LargeFile(force,fname)
"  call Dfunc("s:LargeFile(force=".a:force." fname<".a:fname.">) buf#".bufnr("%")."<".bufname("%")."> g:LargeFile=".g:LargeFile)
  let fsz= getfsize(a:fname)
"  call Decho("fsz=".fsz)
  if a:force || fsz >= g:LargeFile*1024*1024 || fsz <= -2
   sil! call s:ParenMatchOff()
   syn clear
   " buffer variables are used for buffer,window-local options
   " script variables are used for global-only options
   let b:LF_bhkeep  = &l:bh
   let s:LF_bkkeep  = &bk
   let b:LF_cptkeep = &l:cpt
   let s:LF_eikeep  = &ei
   let b:LF_fdmkeep = &l:fdm
   let b:LF_fenkeep = &l:fen
   let s:LF_wbkeep  = &wb
   let b:LF_swfkeep = &l:swf
   if v:version > 704 || (v:version == 704 && has("patch073"))
    let b:LF_ulkeep = &l:ul
   else
    let b:LF_ulkeep = &ul
   endif
   let s:LF_wbkeep  = &l:wb
   set ei=FileType
   if v:version < 704 || (v:version == 704 && has("patch073"))
	setlocal noswf bh=unload fdm=manual nofen cpt-=wbuU nobk nowb ul=-1
   else
    setlocal noswf bh=unload fdm=manual nofen cpt-=wbuU nobk nowb
   endif
   augroup LargeFileAU
    if v:version < 704 || (v:version == 704 && !has("patch073"))
     au BufEnter	<buffer>	call s:LargeFileEnter()
     au BufLeave	<buffer>	call s:LargeFileLeave()
	endif
	au WinEnter		*			call s:LargeFileWinEnter()
    au BufUnload	<buffer>	augroup LargeFileAU|exe 'au! * <buffer>'|augroup END
   augroup END
   let b:LargeFile_mode = 1
"   call Decho("turning  b:LargeFile_mode to ".b:LargeFile_mode)
   echomsg "***note*** handling a large file" 
  elseif exists("s:LF_eikeep")
   let &ei= s:LF_eikeep
  endif
"  call Dret("s:LargeFile")
endfun

" ---------------------------------------------------------------------
" s:LargeFilePost: determines if the file is large enough to warrant LargeFile treatment.  Called via a BufReadPost event.  {{{2
fun! s:LargeFilePost()
"  call Dfunc("s:LargeFilePost() ".line2byte(line("$")+1)."bytes g:LargeFile=".g:LargeFile.(exists("b:LargeFile_mode")? " b:LargeFile_mode=".b:LargeFile_mode : ""))
  if line2byte(line("$")+1) >= g:LargeFile*1024*1024
   if !exists("b:LargeFile_mode") || b:LargeFile_mode == 0
	call s:LargeFile(1,expand("<afile>"))
   endif
  endif
"  call Dret("s:LargeFilePost")
endfun

" ---------------------------------------------------------------------
" s:ParenMatchOff: {{{2
fun! s:ParenMatchOff()
"  call Dfunc("s:ParenMatchOff()")
   redir => matchparen_enabled
    com NoMatchParen
   redir END
   if matchparen_enabled =~ 'g:loaded_matchparen'
	" NoMatchParen uses "windo"; thus it can cause an "E201: *ReadPre autocommands
	" must not change current buffer".  (dhahler@gmail.com)
	let b:LF_nmpkeep = 1
	let curaltwin    = winnr('#')? winnr("#") : 1
	let curwin       = winnr()
	sil! NoMatchParen
	exe curaltwin."wincmd w"
	exe curwin."wincmd w"
   endif
"  call Dret("s:ParenMatchOff")
endfun

" ---------------------------------------------------------------------
" s:Unlarge: this function will undo what the LargeFile autocmd does {{{2
fun! s:Unlarge()
"  call Dfunc("s:Unlarge()")
  let b:LargeFile_mode= 0
"  call Decho("turning  b:LargeFile_mode to ".b:LargeFile_mode)
  if exists("b:LF_bhkeep") |let &l:bh  = b:LF_bhkeep |unlet b:LF_bhkeep |endif
  if exists("s:LF_bkkeep") |let &l:bk  = s:LF_bkkeep |unlet s:LF_bkkeep |endif
  if exists("b:LF_cptkeep")|let &cpt   = b:LF_cptkeep|unlet b:LF_cptkeep|endif
  if exists("s:LF_eikeep") |let &ei    = s:LF_eikeep |unlet s:LF_eikeep |endif
  if exists("b:LF_fdmkeep")|let &l:fdm = b:LF_fdmkeep|unlet b:LF_fdmkeep|endif
  if exists("b:LF_fenkeep")|let &l:fen = b:LF_fenkeep|unlet b:LF_fenkeep|endif
  if exists("b:LF_swfkeep")|let &l:swf = b:LF_swfkeep|unlet b:LF_swfkeep|endif
  if v:version > 704 || (v:version == 704 && has("patch073"))
   if exists("b:LF_ulkeep") |let &l:ul = b:LF_ulkeep |unlet b:LF_ulkeep |endif
  else
   if exists("b:LF_ulkeep") |let &ul   = b:LF_ulkeep |unlet b:LF_ulkeep |endif
  endif
  if exists("s:LF_wbkeep") |let &l:wb  = s:LF_wbkeep |unlet s:LF_wbkeep |endif
  if exists("b:LF_nmpkeep")
   DoMatchParen          
   unlet b:LF_nmpkeep
  endif
  syn on
  doau FileType
  augroup LargeFileAU
   au! * <buffer>
  augroup END
  call s:LargeFileLeave()
  echomsg "***note*** stopped large-file handling"
"  call Dret("s:Unlarge")
endfun

" ---------------------------------------------------------------------
" s:LargeFileEnter: {{{2
fun! s:LargeFileEnter()
"  call Dfunc("s:LargeFileEnter() buf#".bufnr("%")."<".bufname("%").">")
  if has("persistent_undo")
"   call Decho("(s:LargeFileEnter) handling persistent undo: write undo history")
   " Write all undo history:
   "   Turn off all events/autocmds.
   "   Split the buffer so bufdo will always work (ie. won't abandon the current buffer)
   "   Use bufdo
   "   Restorre
   let eikeep= &ei
   set ei=all
   1split
   bufdo exe "wundo! ".fnameescape(undofile(bufname("%")))
   q!
   let &ei= eikeep
  endif
  set ul=-1
"  call Dret("s:LargeFileEnter")
endfun

" ---------------------------------------------------------------------
" s:LargeFileLeave: when leaving a LargeFile, turn undo back on {{{2
"                   This routine is useful for having a LargeFile still open,
"                   but one has changed windows/tabs to edit a different file.
fun! s:LargeFileLeave()
"  call Dfunc("s:LargeFileLeave() buf#".bufnr("%")."<".bufname("%").">")
  " restore undo trees
  if has("persistent_undo")
"   call Decho("(s:LargeFileLeave) handling persistent undo: restoring undo history")
   " Read all undo history:
   "   Turn off all events/autocmds.
   "   Split the buffer so bufdo will always work (ie. won't abandon the current buffer)
   "   Use bufdo
   "   Restore
   let eikeep= &ei
   set ei=all
   1split
   bufdo exe "sil! rundo ".fnameescape(undofile(bufname("%")))|call delete(undofile(bufname("%")))
   q!
   let &ei= eikeep
  endif

  " restore event handling
  if exists("s:LF_eikeep")
   let &ei= s:LF_eikeep
  endif

  " restore undo level
  if exists("b:LF_ulkeep")
   let &ul= b:LF_ulkeep
  endif
"  call Dret("s:LargeFileLeave")
endfun

" ---------------------------------------------------------------------
" s:LargeFileWinEnter: restores/sets global options depending on LargeFile status upon window entry event {{{2
fun! s:LargeFileWinEnter()
"  call Dfunc("s:LargeFileWinEnter()")
  if exists("b:LargeFile_mode") && b:LargeFile_mode
   set nobk ei=FileType
  else
   if exists("s:LF_eikeep")
	let &ei = s:LF_eikeep
   endif
   if exists("s:LF_bkkeep")
	let &bk = s:LF_bkkeep
   endif
   if exists("s:LF_wbkeep")
	let &wb = s:LF_wbkeep
   endif
  endif
"  call Dret("s:LargeFileWinEnter")
endfun

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=4 fdm=marker
