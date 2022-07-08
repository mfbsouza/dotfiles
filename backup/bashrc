# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# colors
CLEAR="\033[01;00m"
RED="\033[01;31m"
GREEN="\033[01;32m"
YELLOW="\033[01;33m"
BLUE="\033[01;34m"


# Highlight the user name when logged in as root.
if [ "$EUID" -ne 0 ]; then
    USER="${GREEN}";
else
    USER="${RED}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	HOST="${RED}";
else
	HOST="${YELLOW}";
fi;

# git
git_prompt() {
	git rev-parse --git-dir >& /dev/null
	if [[ $? == 0 ]]; then
		echo -ne ""
		if [[ `git ls-files -u >& /dev/null` == '' ]]; then
			git diff --quiet >& /dev/null
			if [[ $? == 1 ]]; then
				echo -ne $RED" ("
			else
				git diff --cached --quiet >& /dev/null
				if [[ $? == 1 ]]; then
					echo -ne $RED" ("
				else
					echo -ne $GREEN" ("
				fi
			fi
		else
			echo -ne $BLUE
		fi
		echo -n `git branch | grep '* ' | sed 's/..//'`
		echo -ne ")"
	fi
}

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# prompt style
PS1="\[${USER}\]\u";
PS1+="\[${CLEAR}\] @ ";
PS1+="\[${HOST}\]\h";
PS1+="\[${CLEAR}\] in ";
PS1+="\[${BLUE}\]\w";
PS1+="\$(git_prompt)\[${CLEAR}\]";
PS1+="\n$ ";

export PS1;
