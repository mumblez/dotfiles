# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#

# patch /etc/zprofile to ensure path_helper only runs if NOT tmux, e.g. [ -z $TMUX ]

# Path to your oh-my-zsh installation.
#export ZSH=/Users/yusuf/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="Soliah"
#ZSH_THEME="Avit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git cargo branch brew colored-man-pages command-not-found docker fzf go iterm2 last-working-dir rust terraform tmux zsh_reload)
#plugins=(git zsh-syntax-highlighting zsh-autosuggestions z)

#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
#EDITOR="$VISUAL"
#VISUAL='/usr/bin/local/nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#fpath=(/usr/local/share/zsh-completions $fpath)

#
#

# Enable colors and change prompt:
autoload -U colors && colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
# remove EOL % when command doesn't terminate to new line
PROMPT_EOL_MARK=''

# asdf completions
fpath=(~/.asdf/completions $fpath)

# Basic auto/tab complete:
autoload -Uz compinit
setopt completeinword
zstyle ':completion:*' menu select
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
# lfcd () {
#     tmp="$(mktemp)"
#     lf -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp"
#         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }
# bindkey -s '^o' 'lfcd\n'
#
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
# [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

VISUAL=nvim
EDITOR=$VISUAL

# Plugins
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# Auto load completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    for dump in ~/.zcompdump(N.mh+24); do
        compinit
    done
fi


source ~/google-cloud-sdk/completion.zsh.inc

# brew install olets/tap/zsh-abbr
source /usr/local/share/zsh-abbr/zsh-abbr.zsh


# Import alias
source ~/dotfiles/alias

# Prompt
eval "$(starship init zsh)"

# anything that modifies PATH put in here so it only loads once
if [ -z $TMUX ]; then
    source ~/google-cloud-sdk/path.zsh.inc


    source ~/dotfiles/functions
    source ~/dotfiles/paths

    # asdf
    source ~/.asdf/asdf.sh

    # gpg
    gpgconf --launch gpg-agent
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

    # pyenv init
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    # import aliases into zsh-abbr only once
    # abbr import-aliases &>/dev/null
    abbr load

    # nix
    source ~/.nix-profile/etc/profile.d/nix.sh

fi


# pyenv init
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
source "$(pyenv root)/completions/pyenv.zsh"
# pyenv doctor fix
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/yusuf/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/yusuf/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/yusuf/miniconda3/etc/profile.d/conda.sh"
    else
        [ -z $TMUX ] && export PATH="/Users/yusuf/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
# autojump (j)
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


export NIX_IGNORE_SYMLINK_STORE=1 # catalina fix
export REPO_DIR="${HOME}/repos"
DOTFILES_REPO="$REPO_DIR/dotfiles"
CACHE_DIR="${HOME}/.cache"
[ -d "${CACHE_DIR:-}" ] || mkdir -p "$CACHE_DIR"
VIM_SESSIONS="${CACHE_DIR}/vim-sessions"

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,.terraform,node_modules}/*" --no-messages'
export FZF_CTRL_T_COMMAND='rg --files --no-ignore --hidden --no-follow --glob "!{.git,.terraform,node_modules}/*" --no-messages '
export FZF_ALT_C_COMMAND='rg --files --no-ignore --hidden --no-follow --glob "!{.git,.terraform,node_modules}/*" --null --no-messages | xargs -0 dirname | uniq'

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

export CHEATCOLORS=true
export DEFAULT_CHEAT_DIR="${DOTFILES_REPO}/.cheat"

#source <(gopass completion zsh)
export CHEAT_USE_FZF=true

edge-gcr() {
  local tag
  tag="$1"
  oldimage="eu.gcr.io/thirdeyelabs-common/edge-prod-cuda10.0-amd64:${tag}"
  newimage="europe-west1-docker.pkg.dev/telabs-client-share/stable/edge-prod-cuda10.0-amd64:${tag}"
  [ -z $tag ] && { echo "you need to provide the tag!"; exit 1; }

  echo "Caching image locally"
  docker pull $oldimage
  echo "Re-tagging with new client registry"
  docker tag $oldimage $newimage
  echo "Pushing image..."
  docker push $newimage
}

alias sed='/usr/local/bin/gsed'

# Cleanup PATH with just unique entries
typeset -aU path
