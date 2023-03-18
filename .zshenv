typeset -U path PATH
path+=('/home/gb/.local/bin')
path+=('/home/gb/.bin')
path+=('/usr/local/sbin') # append
path+=('/usr/local/bin')
path+=('/usr/bin')
path+=('/opt/flutter/bin')
path+=('/usr/lib/jvm/default/bin')
path+=('/usr/bin/site_perl')
path+=('/usr/bin/vendor_perl')
path+=('/usr/bin/core_perl')
path+=('/home/gb/Applications/')
path+=('/home/gb/scripts')
path+=('/home/gb/.local/share/nvim/mason')
export PATH

# Clipmenu
export CM_SELECTIONS='clipboard' # don't copy selections
export CM_IGNORE_WINDOW='[Kk]ee[Pp]ass' # don't copy passwords
