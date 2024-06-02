# set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
# set -U fish_user_paths /opt/homebrew/sbin $fish_user_paths
set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias vi nvim
alias v nvim
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH
set -gx PATH $PATH ~/.config/tmux
set -gx PATH $PATH /Users/phuongpd/miniconda3/bin
# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
    status --is-command-substitution; and return

    if test -f .nvmrc; and test -r .nvmrc
        nvm use
    else
    end
end

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/phuongpd/Downloads/google-cloud-sdk/path.fish.inc' ]
    . '/Users/phuongpd/Downloads/google-cloud-sdk/path.fish.inc'
end
source "$(brew --prefix)/share/google-cloud-sdk/path.fish.inc"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
status is-interactive &&
    eval /Users/phuongpd/anaconda3/bin/conda "shell.fish" hook $argv | source
# <<< conda initialize <<<
alias brain="code '/Users/phuongpd/Library/Mobile Documents/iCloud~md~obsidian/Documents/Second Brain'"
# Tmux 
#set DISABLE_AUTO_TITLE true
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold
