# coding: utf-8
def rspec_switch(str) 
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
    return tarf
  end
end


if __FILE__ == $0
  p rspec_switch "aa/aa/aaa.rb"
  p rspec_switch "aaa.rb"
  p rspec_switch "../aaa.rb"
  p rspec_switch "bbb_spec.rb"
  p rspec_switch "spec/bbb_spec.rb"
  p rspec_switch "/usr/ruby/spec/bbb_spec.rb"
end
