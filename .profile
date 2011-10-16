#Paths
export PATH=$PATH:/Applications/Emacs.app/Contents/MacOS/:$HOME/bin:$HOME/development/mobile/OtherScripts:/usr/local/git/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin
export PYTHONPATH=/Users/evanlong/development/tools/python-libs
#dedup the paths
#many thanks from http://codesnippets.joyent.com/posts/show/5049
PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"
PYTHONPATH="$(printf "%s" "${PYTHONPATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"
PATH="${PATH%:}"
PYTHONPATH="${PYTHONPATH%:}"

export EDITOR=emacs

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

#git helpers
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
gnew-team-branch-remote() {
    _assert_arg_count $# 1
    git checkout -b team/$1
    gcreate-remote
}
gnew-branch-remote-named() {
    _assert_arg_count $# 1
    git checkout -b $1
    gcreate-remote
}
#end git helpers

#network helpers
network-slow() {
    _assert_arg_count $# 2
    network-clear
    sudo ipfw add 500 pipe 1 ip from any to any
    sudo ipfw pipe 1 config bw $1kbit/s plr 0 delay $2ms
}
network-slow-128() {
    network-slow 128 50
}
network-slow-64() {
    network-slow 64 50
}
network-clear() {
    sudo ipfw delete 500 2> /dev/null
}
#end network helpers

parse_git_branch() {
    git branch 2>/dev/null | grep '^*'| tr -d [:space:] | tr -d \"*\"
}
#export PS1="\w:\[\033[0;37m\] (\$(parse_git_branch))$(tput sgr0)\$ "
#export PS1="\w $ "
