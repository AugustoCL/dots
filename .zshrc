# General -----------------------------------------------------------------------------------

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# Env Variables (EXPORT) --------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="/usr/bin/vim"
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
#export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PATH=/home/augustocl/.local/bin:/home/augustocl/.nvm/versions/node/v20.2.0/bin:/home/augustocl/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/bin/lua:/sbin:/bin:/bin/lua:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/augustocl/.fzf/bin
export MYVIMRC="$HOME/.vimrc"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Plugins -----------------------------------------------------------------------------------
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    web-search
)

source /home/augustocl/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Appearance -------------------------------------------------------------------------------- 

# Set name of the theme to load --- if set to "random", it will
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="oxide"
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

#less_termcap[md]="${fg_bold[blue]}" # this tells less to print bold text in bold blue


# Functions ---------------------------------------------------------------------------------

# reload .vimrc file across all vim instances in tmux panes
# reload .zshrc file across all zsh instances in tmux panes
function reload-all-vim() {
    tmux list-panes -aF "#{pane_id} #{pane_current_command}" |
    awk '/vim|nvim/ {print $1}' |
    xargs -I {} tmux send-keys -t {} "C-[" ":so ~/.vimrc" "C-m"
}
function reload-all-zsh() {
    tmux list-panes -aF "#{pane_id} #{pane_current_command}" |
    awk '/zsh/ {print $1}' |
    xargs -I {} tmux send-keys -t {} "C-[" "ssource ~/.zshrc" "C-m"
}
alias reloadvimrc="reload-all-vim"
alias reloadzshrc="reload-all-zsh"


# sources -----------------------------------------------------------------------------------
source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# open tmux when open any shell
case $- in *i*)
    [ -z "$TMUX" ] && exec tmux
esac


# remaps and alias --------------------------------------------------------------------------
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char

alias clipv="xclip -sel clip"
alias v="fdfind --type f --hidden --exclude .git | fzf-tmux -p 80% --reverse --preview 'bat {1} -f'| xargs -or vim"
alias glimpse="fzf-tmux -p 80% --reverse --preview 'bat {1} -f'"
alias zshrc="vim ~/.zshrc"
alias bashrc="vim ~/.bashrc"
alias tmuxrc="vim ~/.tmux.conf"
alias vimrc="vim ~/.vimrc"
alias nvimrc="vim ~/.config/nvim/init.lua"
alias tnowrap="tput rmam"
alias twrap="tput smam"


