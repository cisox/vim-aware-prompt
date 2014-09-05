find_vim_runtime() {
    [[ -n "$VIM_SESSION_ROOT" ]] || export VIM_SESSION_ROOT=$PPID
  
    if [[ -n "$VIMRUNTIME" ]]; then
        [[ -d ~/.vimruntimes/$VIM_SESSION_ROOT ]] || mkdir -p ~/.vimruntimes/$VIM_SESSION_ROOT || return 1

        touch ~/.vimruntimes/$VIM_SESSION_ROOT/$PPID

        vim_runtime=''
        for runtime in `ls -1 ~/.vimruntimes/$VIM_SESSION_ROOT`; do
            vim_runtime="$vim_runtime[VIM]"
        done
    else
        [[ ! -d ~/.vimruntimes/$VIM_SESSION_ROOT ]] || rm -f ~/.vimruntimes/$VIM_SESSION_ROOT/*
        vim_runtime=''
    fi
}

clear_vim_runtimes() {
    [[ ! -e ~/.vimruntimes/$VIM_SESSION_ROOT/$PPID ]] || rm ~/.vimruntimes/$VIM_SESSION_ROOT/$PPID || return 1
    [[ $VIM_SESSION_ROOT -ne $PPID ]] || [[ ! -e ~/.vimruntimes/$VIM_SESSION_ROOT ]] || rm -R ~/.vimruntimes/$VIM_SESSION_ROOT || return 1
}

trap clear_vim_runtimes EXIT

PROMPT_COMMAND="find_vim_runtime; $PROMPT_COMMAND"
