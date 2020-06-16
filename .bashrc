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

## COLORS

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	black=$(tput setaf 0);
	blue=$(tput setaf 12);
	cyan=$(tput setaf 14);
	green=$(tput setaf 10);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 9);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 11);
fi;

# Highlight the user name when logged in as root.
if [ "$EUID" -ne 0 ]; then
    userStyle="${green}";
else
    userStyle="${red}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

## GIT INFO

git_prompt() {
  local DIRTY="${red}"
  local CLEAN="${green}"
  local UNMERGED="${blue}"
  local RESET="${reset}"

  git rev-parse --git-dir >& /dev/null
  if [[ $? == 0 ]]; then
    echo -n ""
    if [[ `git ls-files -u >& /dev/null` == '' ]]; then
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]; then
        echo -n $DIRTY" ["
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]; then
          echo -n $DIRTY" ["
        else
          echo -n $CLEAN" ["
        fi
      fi
    else
      echo -n $UNMERGED
    fi
    echo -n `git branch | grep '* ' | sed 's/..//'`
	echo -n "]"
  fi
}

alias ls='ls --color=auto'


## PROMPT STYLE

PS1="\[${userStyle}\]\u";
PS1+="\[${white}\] @ ";
PS1+="\[${hostStyle}\]\h";
PS1+="\[${white}\] in ";
PS1+="\[${blue}\]\w";
PS1+="\$(git_prompt)\[${reset}\]";
PS1+="\n";
PS1+="\[${bold}\]\$ \[${reset}\]"

export PS1;
