function! ORSSwitch()
  let a:tpath = expand("%:p")
  ruby <<EOF
  str=File.expand_path(VIM.evaluate('a:tpath'))
  if(str.match(/.*\.rb$/))
    if(str.match(/.*_spec\.rb$/))
      stra=str.split("/")
      stra[-1].sub!(/(.*)\_spec.rb/x){$1 + ".rb"}  
      stra.delete_at(-2)
      tarf =stra.join("/")
    elsif(str.match(/.*\.rb$/))
      stra=str.split("/")
      stra[-1].sub!(/(.*)\.rb/){$1+"_spec.rb"}
      stra[-1,0]="spec"
      tarf = stra.join("/")
    end
    #unless File.exist?(tarf)
    #   File.open(tarf,"w").close()
    #end
    VIM.command("edit " + tarf)
  end
EOF
endfunction

function! RSSwitch()
  let a:tpath = expand("%:p")
  let a:bpath = BuddyGetPath(a:tpath)
  silent exec "edit " . a:bpath 
endfunction

function! BuddyGetPath(tpath)
  let bpath = ""
  ruby <<EOF
  str=File.expand_path(VIM.evaluate('a:tpath'))
  if(str.match(/.*\.rb$/))
    if(str.match(/.*_spec\.rb$/))
      stra=str.split("/")
      stra[-1].sub!(/(.*)\_spec.rb/x){$1 + ".rb"}  
      stra.delete_at(-2)
      tarf =stra.join("/")
    elsif(str.match(/.*\.rb$/))
      stra=str.split("/")
      stra[-1].sub!(/(.*)\.rb/){$1+"_spec.rb"}
      stra[-1,0]="spec"
      tarf = stra.join("/")
    end
    #unless File.exist?(tarf)
    #   File.open(tarf,"w").close()
    #end
    VIM.command('let bpath = "' + tarf +'"')
  end
EOF
  return bpath
endfunction

function! VRSSwitch()
  vsplit
  call RSSwitch()
endfunction

function! SRSSwitch()
  split
  call RSSwitch()
endfunction

function! RunSpec()
  let a:tpath = expand("%:p")
  let bbufno = bufwinnr(bufnr("%"))
  if a:tpath =~ ".*_spec\.rb"
    let a:bpath = a:tpath
  else
    let a:bpath = BuddyGetPath(a:tpath)
  endif

  echo a:bpath

  if bufnr('rspec_result_out') == -1
    silent exec "botright 8new rspec_result_out"
    silent exec "set buftype=nofile"
  else
    execute bufwinnr(bufnr('rspec_result_out')).'wincmd w'
  endif

  silent 1,$delete

  silent exec "r!rspec " . a:bpath
  call append('0',"    ".a:bpath)
  call append('0',"Target specfile:")
	setl syntax=buddy-switch.vim

  silent exec bbufno."wincmd W"
endfunction

function! ORunSpec()
  let l:specfile = expand("%:p")
  silent exec "vsplit rspec_result_out"
  silent exec "set buftype=nofile"
  silent exec "r!rspec " . l:specfile
endfunction
