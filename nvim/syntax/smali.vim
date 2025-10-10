" Vim syntax file
" Language: Smali
" Maintainer: You
" Last Change: 2025-05-08

if exists("b:current_syntax")
  finish
endif

syntax case ignore

" Comments
syntax match smaliComment ";.*$"
highlight link smaliComment Comment

" Strings
syntax region smaliString start=+"+ skip=+\\\\\|\\"+ end=+"+
highlight link smaliString String

" Class, method, field declarations
syntax match smaliDirective "\.\(class\|super\|method\|end method\|field\|end field\|locals\|registers\)"
highlight link smaliDirective Keyword

" Access modifiers
syntax match smaliAccess "\<\(public\|private\|protected\|static\|final\|abstract\|synthetic\|constructor\|native\|interface\|enum\)\>"
highlight link smaliAccess Type

" Registers
syntax match smaliRegister "\<[vp][0-9]\+\>"
highlight link smaliRegister Identifier

" Instructions
syntax match smaliOpcode "\<\([a-z][a-z_0-9]*\)\>"
highlight link smaliOpcode Statement

" Labels
syntax match smaliLabel ":\w\+"
highlight link smaliLabel Label

" Literals
syntax match smaliNumber "\<0x[0-9a-fA-F]\+\>"
syntax match smaliNumber "\<\d\+\>"
highlight link smaliNumber Number

let b:current_syntax = "smali"

