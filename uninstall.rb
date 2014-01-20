require "fileutils"

alias :L :lambda

Joiner = L { |base| L { |*others| File.join(base, *others) } }
Remove = L { |link| FileUtils.rm(link) rescue puts "#{link} not found." }

Home   = Joiner[ File.expand_path("~") ]

Remove[ Home[".emacs"]   ]
Remove[ Home[".emacs.d"] ]
