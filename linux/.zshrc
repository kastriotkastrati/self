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

[ -f ~/data/env-variables/.shell-variables ] && . ~/data/env-variables/.shell-variables
[ -f ~/.config/.zshrc-private ] && . ~/.config/.zshrc-private

export PIPENV_VENV_IN_PROJECT=1

alias python='python3'
alias pip='pip3'
alias vim='nvim'
alias copy='xclip -selection clipboard'
alias connect-earbuds='bluetoothctl connect $EARBUDS_MAC_ADDRESS'
alias disconnect-earbuds='bluetoothctl disconnect $EARBUDS_MAC_ADDRESS'
alias connect-airpods='bluetoothctl connect $AIRPODS_MAC_ADDRESS'
alias connect-headphones='bluetoothctl connect $HEADPHONES_MAC_ADDRESS'
alias openr=$(whence -p open)
alias open='ranger'
alias htop='btop'
alias ls='eza'
alias lw='eza --time=created --sort=created --group-directories-first --long --no-user --no-filesize'
alias nixfind='f() { nix-env -qaP "$1" 2>/dev/null | column -t; }; f'

lvim() {
  (
    source ~/coding/envs/nodevenv/bin/activate
    NVIM_APPNAME=lvim nvim "$@"
  )
}

claudew() {
  local window_k="${1:-200}"
  shift
  local effort=""
  if [[ "${1:-}" =~ ^(low|medium|high|xhigh|max)$ ]]; then
    effort="$1"
    shift
  fi
  local model=""
  case "${1:-}" in
    opus55) model="claude-opus-5-5[1m]"; shift ;;
    opus50) model="claude-opus-5[1m]"; shift ;;
    opus48) model="claude-opus-4-8[1m]"; shift ;;
    opus46) model="claude-opus-4-6[1m]"; shift ;;
    fable) model="claude-fable-5[1m]"; shift ;;
    fable52) model="claude-fable-5-2[1m]"; shift ;;
    sonnet) model="claude-sonnet-4-6[1m]"; shift ;;
    haiku) model="claude-haiku-4-5"; shift ;;
  esac
  if [[ -z "$model" ]]; then
    print -u2 "claude: pick a model — opus55 / opus50 / opus48 / opus46 / fable / fable52 / sonnet / haiku"
    return 2
  fi
  local env_args=(
    "CLAUDE_CODE_AUTO_COMPACT_WINDOW=$(( window_k * 1000 ))"
    "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=95"
  )
  [[ -n "$effort" ]] && env_args+=("CLAUDE_CODE_EFFORT_LEVEL=$effort")
  env "${env_args[@]}" claude --model "$model" "$@"
}

claude() {
  if [[ $# -eq 0 ]]; then
    print -u2 "claude: pick a context window — claude200 / claude300 / claude500 / claude1m, or 'claudew <N-thousand>'"
    return 2
  fi
  case "${1:-}" in
    fable)
      claudew 1000 "$@"
      ;;
    *)
      command claude "$@"
      ;;
  esac
}

codexw() {
  local window_k="${1:-300}"
  shift
  if [[ ! "$window_k" =~ ^[0-9]+$ ]]; then
    print -u2 "codex: context size must be a number in thousands, e.g. 200"
    return 2
  fi
  local effort=""
  if [[ "${1:-}" =~ ^(low|medium|high|xhigh|max)$ ]]; then
    effort="$1"
    shift
  fi
  local model=""
  case "${1:-}" in
    sol|sol61|gpt61-sol|gpt-6.1-sol) model="gpt-6.1-sol"; shift ;;
    gpt6-sol|gpt-6-sol) model="gpt-6-sol"; shift ;;
    terra|gpt56-terra|gpt-5.6-terra) model="gpt-5.6-terra"; shift ;;
    luna|gpt6-luna|gpt-6-luna) model="gpt-6-luna"; shift ;;
    astra|gpt6-astra|gpt-6-astra) model="gpt-6-astra"; shift ;;
    codex53|gpt53-codex|gpt-5.3-codex) model="gpt-5.3-codex"; shift ;;
  esac
  if [[ -z "$model" ]]; then
    print -u2 "codex: pick a model — sol / luna / astra / terra / codex53, or 'codexw <N-thousand> [effort] <model>'"
    return 2
  fi
  local config_args=(-c "model_auto_compact_token_limit=$(( window_k * 1000 ))")
  [[ -n "$effort" ]] && config_args+=(-c "model_reasoning_effort=$effort")
  command codex --model "$model" "${config_args[@]}" "$@"
}

codex() {
  if [[ $# -eq 0 ]]; then
    print -u2 "codex: pick a context size — codex300 / codex500 / codex1m, or 'codexw <N-thousand>'"
    return 2
  fi
  case "${1:-}" in
    astra|gpt6-astra|gpt-6-astra)
      codexw 300 "$@"
      ;;
    *)
      command codex "$@"
      ;;
  esac
}

piw() {
  if [[ ! "${1:-}" =~ ^[0-9]+$ || ${#1} -gt 7 ]]; then
    print -u2 "pi: context size must be a number in thousands, e.g. 'piw 200 high sonnet'"
    return 2
  fi
  local window_k=$(( 10#$1 ))
  shift
  if [[ $window_k -lt 40 ]]; then
    print -u2 "pi: context size must be at least 40 (40,000 tokens)"
    return 2
  fi
  local thinking_args=()
  case "${1:-}" in
    off|minimal|low|medium|high|xhigh|max)
      thinking_args=(--thinking "$1")
      shift
      ;;
  esac
  if [[ -z "${1:-}" || "$1" == -* ]]; then
    print -u2 "pi: pick a model — 'piw <N-thousand> [effort] <model> [pi options]'"
    return 2
  fi
  local model="$1"
  shift
  command pi --context-window "$(( window_k * 1000 ))" --model "$model" "${thinking_args[@]}" "$@"
}

pi() {
  if [[ $# -eq 0 ]]; then
    print -u2 "pi: pick a context window — pi200 / pi300 / pi500 / pi1m, or 'piw <N-thousand> [effort] <model>'"
    return 2
  fi
  case "${1:-}" in
    fable)
      shift
      piw 1000 claude-code/claude-fable-5-1 "$@"
      ;;
    astra|gpt6-astra|gpt-6-astra)
      shift
      piw 300 openai-codex/gpt-6-astra "$@"
      ;;
    *)
      command pi "$@"
      ;;
  esac
}

opencode-old() {
  local wid=$ALACRITTY_WINDOW_ID
  [[ -n $wid ]] || { command opencode "$@"; return; }
  alacritty msg config -w $wid 'keyboard.bindings=[{ key = "Escape", mode = "~Vi|Alt", action = "ToggleViMode" }]'
  trap "alacritty msg config -w $wid -r" EXIT
  command opencode "$@"
}

opencode() {
  case ${1-} in
    attach)
      command opencode "$@" --mini
      ;;
    completion|acp|mcp|run|debug|providers|auth|agent|upgrade|uninstall|serve|web|models|stats|export|import|github|pr|session|plugin|plug|db)
      command opencode "$@"
      ;;
    *)
      command opencode --mini "$@"
      ;;
  esac
}

qwen() {
  (
    source ~/coding/nodevenv/bin/activate
    command qwen "$@"
  )
}

bindkey -v

export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri
export PAGER='less -FX'

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"

if [[ -o interactive ]]; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

export EDITOR='vim'

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# OpenClaw Completion
[ -f "$HOME/.openclaw/completions/openclaw.zsh" ] && source "$HOME/.openclaw/completions/openclaw.zsh"

alias claude200='claudew 200'
alias claude300='claudew 300'
alias claude500='claudew 500'
alias claude1m='claudew 1000'
alias codex300='codexw 300'
alias codex500='codexw 500'
alias codex1m='codexw 1000'
alias pi200='piw 200'
alias pi300='piw 300'
alias pi500='piw 500'
alias pi1m='piw 1000'





# Added by Antigravity CLI installer
export PATH="$HOME/.local/bin:$PATH"
alias agy="agy --dangerously-skip-permissions"
export PATH="$HOME/.terragrunt/bin:$PATH"
[ -x ~/.local/bin/mise ] && eval "$(~/.local/bin/mise activate zsh)"

# Load project-local environment variables and PATH entries.
if command -v direnv >/dev/null 2>&1; then
  export DIRENV_LOG_FORMAT=""
  eval "$(direnv hook zsh)"
fi
export PATH="$HOME/.elan/bin:$PATH"

# Vite+ bin (https://viteplus.dev)
[ -f "$HOME/.config/vite-plus/env" ] && . "$HOME/.config/vite-plus/env"

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

[ -f ~/.zshrc.local ] && . ~/.zshrc.local
