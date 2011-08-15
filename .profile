#Paths
export PATH=$PATH:/Applications/Emacs.app/Contents/MacOS/:$HOME/bin:$HOME/development/mobile/OtherScripts
export PYTHONPATH=/Users/evanlong/development/tools/python-libs

alias ll="ls -l"
alias la="ls -a"
alias up="pushd .."
alias up1="pushd .."
alias up2="pushd ../../"
alias up3="pushd ../../../"
alias up4="pushd ../../../../"
alias up5="pushd ../../../../../"
alias up6="pushd ../../../../../../"
alias up7="pushd ../../../../../../../"
alias up8="pushd ../../../../../../../../"

#only hidden files
alias llh="ls -A1 | grep \"^\.\""

#git
alias gup="git up"
alias gst="git status"
alias glog="git log"
alias gbra="git branch"
alias gdiff="git diff"

parse_git_branch() {
    git branch 2>/dev/null | grep '^*'| tr -d [:space:] | tr -d \"*\"
}
#export PS1="\w:\[\033[0;37m\] (\$(parse_git_branch))$(tput sgr0)\$ "
