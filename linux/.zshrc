# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="lambda"
#ZSH_THEME="robbyrussell"
ZSH_THEME="fwalch"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
DISABLE_AUTO_TITLE="true"

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf python)

source $ZSH/oh-my-zsh.sh

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
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function precmd {
  print -Pn "\e]0;%~\a"
}

. ~/data/.shell-variables
. ~/.config/.zshrc-private

export PIPENV_VENV_IN_PROJECT=1

eval "$(zoxide init zsh)"
alias python='python3'
alias pip='pip3'
alias vim='nvim'
alias cd='z'
alias copy='xclip -sel clip'
alias connect-airpods='bluetoothctl connect $AIRPODS_MAC_ADDRESS'
alias connect-headphones='bluetoothctl connect $HEADPHONES_MAC_ADDRESS'
alias openr=$(whence -p open)
alias open='ranger'
alias htop='btop'
alias ls='eza'
alias lw='eza --time=created --sort=created --group-directories-first --long --no-user --no-filesize'
alias nixfind='f() { nix-env -qaP "$1" 2>/dev/null | column -t; }; f'

# Claude Code: cap auto-compact window (in thousands) and optionally set effort level
# Usage: claudew <window-k> [effort] [claude args...]
#   claudew 300            -> 300k window
#   claudew 300 max        -> 300k window, effort=max
#   claudew 300 xhigh -c   -> 300k window, effort=xhigh, passes -c to claude
claudew() {
  local window_k="${1:-200}"
  shift
  local effort=""
  if [[ "${1:-}" =~ ^(low|medium|high|xhigh|max)$ ]]; then
    effort="$1"
    shift
  fi
  local env_args=(
    "CLAUDE_CODE_AUTO_COMPACT_WINDOW=$(( window_k * 1000 ))"
    "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=95"
  )
  [[ -n "$effort" ]] && env_args+=("CLAUDE_CODE_EFFORT_LEVEL=$effort")
  env "${env_args[@]}" claude "$@"
}
alias claude200='claudew 200'
alias claude300='claudew 300'
alias claude500='claudew 500'
alias claude1m='command claude'

# Force explicit context-window choice — bare `claude` errors out
claude() {
  if [[ $# -eq 0 ]]; then
    print -u2 "claude: pick a context window — claude200 / claude300 / claude500 / claude1m, or 'claudew <N-thousand>'"
    return 2
  fi
  command claude "$@"
}


bindkey -v




# bun completions
[ -s "/home/kastriotkastrati/.bun/_bun" ] && source "/home/kastriotkastrati/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri
