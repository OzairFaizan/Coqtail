" Vim syntax file
" Language:     Coq-goals
" Filenames:    *.v
" Maintainer:  Laurent Georget <laurent@lgeorget.eu>
" Last Change: 2015 Jul 07 - Initial syntax coloring, pretty stable
" License:     public domain
" Modified By: Wolf Honore

" Only load this syntax file when no other was loaded and user didn't opt out.
if exists('b:current_syntax') || get(g:, 'coqtail_nosyntax', 0)
  finish
endif

" Keywords are alphanumeric, _, and '
setlocal iskeyword=@,48-57,192-255,_,'
syn iskeyword clear

" Rocq is case sensitive.
syn case match

" Various
" syn match   coqError             "\S\+"
syn match   coqVernacPunctuation ":=\|\.\|:"
syn match   coqIdent             contained "[[:digit:]']\@!\k\k*"

" Number of goals
syn match   coqNumberGoals       "\d\+ subgoals\?"
syn match   coqNumberUnfocused   "(\d\+ unfocused at this level)"
syn match   coqNumberAdmitted    "\d\+ admitted"
syn match   coqNumberShelved     "\d\+ shelved"

" Hypothesis
syn region  coqHypothesisBlock  contains=coqHypothesis start="^[[:digit:]']\@!\k\k*" end="^$" keepend
syn region  coqHypothesis       contained contains=coqHypothesisList,coqHypothesisBody start="^[[:digit:]']\@!\k\k*" matchgroup=NONE end="^\S"me=e-1
syn region  coqHypothesisList   contained contains=coqIdent start="^[[:digit:]']\@!\k\k*" matchgroup=NONE end=":"me=e-1 end=":="me=e-2
syn region  coqHypothesisBody   contained contains=@coqTerm matchgroup=coqVernacPunctuation start=":=\?" matchgroup=NONE end="^\S"me=e-1

" Separator
syn region  coqGoalSep          matchgroup=coqGoalLine start="^=\+" matchgroup=NONE end="^$\n" contains=coqGoalNumber,coqGoalName nextgroup=coqGoalBlock keepend
syn match   coqGoalNumber       contained "(\s*\d\+\s*\/\s*\d\+\s*)"
syn region  coqGoalName         contained start="\[" end="]" keepend
syn region  coqNextGoal         start="Next goal" end="^$\n" nextgroup=coqGoalBlock keepend

" Goals
syn region coqGoalBlock contained contains=@coqTerm start="\S" end="^$"

" Terms
syn cluster coqTerm            contains=coqKwd,coqTermPunctuation,coqKwdMatch,coqKwdLet,coqKwdParen,coqString
syn region coqKwdMatch         contained contains=@coqTerm matchgroup=coqKwd start="\<match\>" end="\<with\>"
syn region coqKwdLet           contained contains=@coqTerm matchgroup=coqKwd start="\<let\>"   end=":="
syn region coqKwdParen         contained contains=@coqTerm matchgroup=coqTermPunctuation start="(" end=")" keepend extend
syn keyword coqKwd             contained else end exists2 fix if in struct then as return
syn keyword coqKwd             contained forall conceal cchar=∀
syn keyword coqKwd             contained fun conceal cchar=λ
syn match coqKwd               contained /\/\\/ conceal cchar=∧
syn match coqKwd               contained /\\\// conceal cchar=∨
syn match   coqKwd             contained "\~" conceal cchar=¬
syn match   coqKwd             contained "\<where\>"
syn match   coqKwd             contained "\<exists!\?\>" conceal cchar=∃
syn match   coqKwd             contained "|\|<->\|->\|=>\|{\|}\|&\|+\|-\|*\|=\|>\|<\|<="
syn match coqTermPunctuation   contained ":=\|:>\|:\|;\|,\|||\|\[\|\]\|@\|?\|\<_\>"

syn match coqSub0 "\%([a-zA-Z]\d*\)\@<=\(0\d*'*\>\)\@=0" conceal cchar=₀ containedin=ALL
syn match coqSub1 "\%([a-zA-Z]\d*\)\@<=\(1\d*'*\>\)\@=1" conceal cchar=₁ containedin=ALL
syn match coqSub2 "\%([a-zA-Z]\d*\)\@<=\(2\d*'*\>\)\@=2" conceal cchar=₂ containedin=ALL
syn match coqSub3 "\%([a-zA-Z]\d*\)\@<=\(3\d*'*\>\)\@=3" conceal cchar=₃ containedin=ALL
syn match coqSub4 "\%([a-zA-Z]\d*\)\@<=\(4\d*'*\>\)\@=4" conceal cchar=₄ containedin=ALL
syn match coqSub5 "\%([a-zA-Z]\d*\)\@<=\(5\d*'*\>\)\@=5" conceal cchar=₅ containedin=ALL
syn match coqSub6 "\%([a-zA-Z]\d*\)\@<=\(6\d*'*\>\)\@=6" conceal cchar=₆ containedin=ALL
syn match coqSub7 "\%([a-zA-Z]\d*\)\@<=\(7\d*'*\>\)\@=7" conceal cchar=₇ containedin=ALL
syn match coqSub8 "\%([a-zA-Z]\d*\)\@<=\(8\d*'*\>\)\@=8" conceal cchar=₈ containedin=ALL
syn match coqSub9 "\%([a-zA-Z]\d*\)\@<=\(9\d*'*\>\)\@=9" conceal cchar=₉ containedin=ALL

" Various (High priority)
syn region  coqString            start=+"+ skip=+""+ end=+"+ extend

" Synchronization
syn sync minlines=50
syn sync maxlines=500

" Define the default highlighting.
command -nargs=+ HiLink hi def link <args>

" TERMS AND TYPES
HiLink coqTerm              Type
HiLink coqKwd               coqTerm
HiLink coqTermPunctuation   coqTerm

" WORK LEFT
HiLink coqNumberGoals       Todo
HiLink coqNumberUnfocused   Todo
HiLink coqNumberAdmitted    Error
HiLink coqNumberShelved     Todo
HiLink coqGoalLine          Todo

" GOAL IDENTIFIER
HiLink coqGoalNumber        Underlined
HiLink coqGoalName          Underlined
HiLink coqNextGoal          Underlined

" USUAL VIM HIGHLIGHTINGS
" Comments
HiLink coqComment           Comment

" Strings
HiLink coqString            String

delcommand HiLink

let b:current_syntax = 'coq-goals'
