# --- Environment Variables & Paths ---
export EDITOR="hx"
export VISUAL="hx"

export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.opencode/bin:$BUN_INSTALL/bin:$PNPM_HOME:/snap/bin:$PATH"

export FZF_DEFAULT_OPTS='
    --color=fg:#e5e9f0,bg:#2E3440,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#2E3440,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

# --- Plugin Manager (Zinit) ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-completions

# --- Shell Options & Keybindings ---
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Edit command line in Helix with Ctrl-b + e
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^b^e' edit-command-line

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

autoload -Uz compinit && compinit
zinit cdreplay -q

source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Load custom scripts
for file in ~/.zsh/*.zsh; do
  source "$file"
done

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"

precmd() print -Pn "\e]2;%~\a"
