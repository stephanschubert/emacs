require "fileutils"

alias :L :lambda

Joiner = L { |base| L { |*others| File.join(base, *others) } }
Link   = L { |from, to| FileUtils.ln_s(from, to) rescue puts("#{to} exists.") }

Cwd    = Joiner[ File.expand_path(File.dirname(__FILE__)) ]
Home   = Joiner[ File.expand_path("~") ]

Link[ Cwd['.emacs'],   Home['.emacs']   ]
Link[ Cwd['.emacs.d'], Home['.emacs.d'] ]