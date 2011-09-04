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
alias gsho="git show"
alias gco="git checkout"
alias gcom="git checkout master"

function _assert_arg_count() {
    n=$1
    e=$2
    if [ ! $n -eq $e ]
    then
        echo "gave $n args needed $e"
    fi
}

gcreate-remote() {
    BNAME=$(git branch 2>/dev/null | grep '^*' | tr -d [:space:] | tr -d \"*\")
    git push -u origin $BNAME
}
gbra-mine() {
    git branch -r | grep evan
}
gkill-mine () {
    _assert_arg_count $# 1
    gbra -D evan/$1
    git push origin :evan/$1
}
gnew-branch() {
    _assert_arg_count $# 1
    git checkout -b evan/$1
}
gnew-branch-remote() {
    _assert_arg_count $# 1
    git checkout -b evan/$1
    gcreate-remote
}

parse_git_branch() {
    git branch 2>/dev/null | grep '^*'| tr -d [:space:] | tr -d \"*\"
}
#export PS1="\w:\[\033[0;37m\] (\$(parse_git_branch))$(tput sgr0)\$ "
export PS1="\w $ "
