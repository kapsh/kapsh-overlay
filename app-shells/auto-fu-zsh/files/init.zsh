# From https://github.com/vaeth/zshrc-mv/blob/master/zshrc

# Activate incremental completion, see https://github.com/hchbaw/auto-fu.zsh/
# (Only the most current versions [branch pu] work with syntax-highlighting)

if (($+functions[auto-fu-init])) || {
    : # Status must be 0 before sourcing auto-fu.zsh
    path=(${DEFAULTS:+${^DEFAULTS%/}/zsh{/auto-fu{.zsh,},}} \
        /usr/share/zsh/site-contrib{/auto-fu{.zsh,},}) \
        . auto-fu NIL && auto-fu-install
    } || {
    :
    path=(${DEFAULTS:+${^DEFAULTS%/}/zsh{/auto-fu{.zsh,},}} \
        /usr/share/zsh/site-contrib{/auto-fu{.zsh,},}) \
        . auto-fu.zsh NIL
    }
then    # auto-fu.zsh gives confusing messages with warn_create_global:
    setopt no_warn_create_global
    # Keep Ctrl-d behavior also when auto-fu is active
    afu+orf-ignoreeof-deletechar-list() {
    afu-eof-maybe afu-ignore-eof zle kill-line-maybe
}
    afu+orf-exit-deletechar-list() {
    afu-eof-maybe exit zle kill-line-maybe
}
    zstyle ':auto-fu:highlight' input
    zstyle ':auto-fu:highlight' completion fg=yellow
    zstyle ':auto-fu:highlight' completion/one fg=white
    zstyle ':auto-fu:var' postdisplay # $'\n-azfu-'
    zstyle ':auto-fu:var' track-keymap-skip opp
    zstyle ':auto-fu:var' enable all
    zstyle ':auto-fu:var' disable magic-space
    if (($+functions[init-transmit-mode]))
    then    zle-line-init() {
    init-transmit-mode
    auto-fu-init
}
        zle -N zle-line-init
    else    zle -N zle-line-init auto-fu-init
    fi
    zle -N zle-keymap-select auto-fu-zle-keymap-select
    zstyle ':completion:*' completer _complete

    # Starting a line with a space or tab or quoting the first word
    # or escaping a word should deactivate auto-fu for that line/word.
    # This is useful e.g. if auto-fu is too slow for you in some cases.
    # Unfortunately, for eix auto-fu is always too slow...
    zstyle ':auto-fu:var' autoable-function/skiplines '[[:blank:]\\"'\'']*|(emerge|eix(|.32|.64))[[:blank:]]*'
    zstyle ':auto-fu:var' autoable-function/skipwords '[\\]*'
fi
