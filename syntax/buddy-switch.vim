syntax match buddyHeader /^*/
syntax match buddyTitle /^\[.\+/
syntax match buddyOk /^+.\+/
syntax match buddyError /^-.\+/
syntax match buddyErrorDetail /^  \w.\+/
syntax match buddyErrorURL /^  \/.\+/
syntax match buddyNotImplemented /^#.\+/
syntax match buddyCode /^  \d\+:/

highlight link buddyHeader Type 
highlight link buddyTitle Identifier 
highlight link buddyOk    Tag
highlight link buddyError Error
highlight link buddyErrorDetail Constant
highlight link buddyErrorURL PreProc
highlight link buddyNotImplemented Todo
highlight link buddyCode Type 
