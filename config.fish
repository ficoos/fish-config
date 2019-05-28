function hg_branch
    has_command hg; and hg branch ^ /dev/null | awk '{print $1}'
end

function has_command
    which $argv 2> /dev/null > /dev/null
end

function __scm_prompt
	set gitps (__fish_git_prompt | string trim -c '() ')
	set hgps (hg_branch)
	if [ -n "$gitps" ]
		echo " (git:$gitps)";
	else if [ -n "$hgps" ]
		echo " (hg:$hgps)"
	else
		echo ""
	end
end

function fish_prompt
    echo -e "\033[32m["(date +%T)"]\033[0m "(whoami)"\033[38;5;8m@\033[38;5;7m"(hostname) "\033[36m"(pwd | string replace -r "^$HOME" '~')"\033[35m"(__scm_prompt)"\033[0m\n\$ "(tput sgr0)
end

function fish_greeting
    has_command fortune cowsay; and fortune | cowsay
end

function vim
	if [ "$NVIM_LISTEN_ADDRESS" = "" ]
		nvim $argv
	else
		nvr $argv
	end
end

function viconf
	 nvim ~/.config/nvim/init.vim
end

function pfzf
	pass fzf $argv
end

function tkak
	set session_name (basename $PWD)
	tmux new kak $argv
end

set --export PATH $PATH $HOME/.bin
set --export PATH "$HOME/.cargo/bin" $PATH
set --export PATH "$HOME/go/bin" $PATH
set --export PASSWORD_STORE_ENABLE_EXTENSIONS true
set --export ANSIBLE_NOCOWS 1
set --export PIP_INDEX_URL "https://devpi.gmpl/root/pypi/+simple/"
set --export PIPENV_PYPI_MIRROR $PIP_INDEX_URL
set --export PIP_TRUSTED_HOST "devpi.gmpl"

set --export EDITOR nvim
