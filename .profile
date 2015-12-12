#probably the MOST important alias of all
alias vim=emacs

export PATH=/Users/evanlong/development/Environments/Python/Default/bin:$HOME/bin:$PATH
#dedup the paths
#many thanks from http://codesnippets.joyent.com/posts/show/5049
PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"
PYTHONPATH="$(printf "%s" "${PYTHONPATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"
PATH="${PATH%:}"
PYTHONPATH="${PYTHONPATH%:}"

export PYTHONSTARTUP=~/.pythonrc
export EDITOR=emacs
# export LSCOLORS=ExFxBxDxCxegedabagacad
# export CLICOLOR=1

#pretty colors
alias grep="grep --color=auto"
alias ls='ls -GFh'
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

#efffing Xcode
alias fuxcode="killall -9 Xcode"

#only hidden files
alias llh="ls -A1 | grep \"^\.\""

#servers
alias servedir="python -m SimpleHTTPServer 8000 ."

# Determines public ip address
publicip() {
    curl http://ip.appspot.com
    echo
}
localip() {
    service=$1
    if [ -z $service ]
    then
        service="Wi-Fi"
    fi

    networksetup -getinfo $service | grep --color=none "IP address"
}


listNetworkServices() {
    networksetup -listallnetworkservices
}

setSocksPort() {
    port=$1
    if [ -z $port ]
    then
        port=8989
    fi

    service=$2
    if [ -z $service ]
    then
        service="Wi-Fi"
    fi
    sudo networksetup -setsocksfirewallproxy $service localhost $port
}

enableSocks() {
    service=$1
    if [ -z $service ]
    then
        service="Wi-Fi"
    fi
    sudo networksetup -setsocksfirewallproxystate $service on
}

disableSocks() {
    service=$1
    if [ -z $service ]
    then
        service="Wi-Fi"
    fi
    echo "May need to enter sudo password..."
    sudo networksetup -setsocksfirewallproxystate $service off
}

beginSocksSession() {
    echo "Starting SOCKS session"
    setSocksPort 9000
    enableSocks
    ssh annglove@evanlong.org -D 9000
    disableSocks
    echo "Ended SOCKS session"
}

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
gtrack-branch() {
    _assert_arg_count $# 1
    git branch --track $1 origin/$1
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

#setup extra path variables based on a file
add-to-path() {
    export PATH=$1:$PATH
}
remove-from-path() {
    export PATH=${PATH/$1:/}
}
cleanup-env() {
    for line in `cat $1`
    do
        remove-from-path $line
    done
}
setup-env() {
    for line in `cat $1`
    do
        add-to-path $line
    done
}

cd() {
    if [ -e .__custom_env ]
    then
        cleanup-env ./.__custom_env
    fi

    builtin cd "$@"

    if [ -e .__custom_env ]
    then
        setup-env ./.__custom_env
    fi
}

cdf () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

loopcmd () {
    cmd=$1
    delay=$2

    if [ -z $cmd ]
    then
        echo "Usage: loopcmd COMMAND [DELAY]"
        return 1
    fi

    if [ -z $delay ]
    then
        delay=2
    fi

    while [ true ]; do
        $cmd
        sleep $delay
    done
}

#git autocomplete
source ~/.git-completion.bash

#makes sharing of files a bit easier via http
sendtoserver() {
    `echo "http://files.evanlong.info/rsynced/$1" | pbcopy`
    rsync -av "$1" website@evanlong.info:~/files.evanlong.info/root/rsynced/
}
sendtodropbox() {
    `echo "http://dl.dropbox.com/u/126589/rsynced/$1" | pbcopy`
    cp -r "$1" ~/Dropbox/Public/rsynced/
}

#virtual box helpers
mountvboxshare() {
    wami=`whoami`
    sudo mount -t vboxsf -o uid=`id -u $wami`,gid=`id -g $wami` $1 /home/$wami/$1
}

#ios simulator helpers
_install-cert() {
    if [ -f "$SQLITEDBPATH" ]; then
        cp -n "$SQLITEDBPATH" "$SQLITEDBPATH.charlesbackup"
        sqlite3 "$SQLITEDBPATH" <<EOF
INSERT INTO "tsettings" VALUES(X'189B6E28D1635F3A8325E1E002180DBA2C02C241',X'3123302106035504030C1A436861726C65732050726F78792053534C2050726F7879696E6731243022060355040B0C1B687474703A2F2F636861726C657370726F78792E636F6D2F73736C3111300F060355040A0C08584B3732204C74643111300F06035504070C084175636B6C616E643111300F06035504080C084175636B6C616E64310B3009060355040613024E5A',X'3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C21444F435459504520706C697374205055424C494320222D2F2F4170706C652F2F44544420504C49535420312E302F2F454E222022687474703A2F2F7777772E6170706C652E636F6D2F445444732F50726F70657274794C6973742D312E302E647464223E0A3C706C6973742076657273696F6E3D22312E30223E0A3C61727261792F3E0A3C2F706C6973743E0A',X'3082045E30820346A003020102020101300D06092A864886F70D01010505003081913123302106035504030C1A436861726C65732050726F78792053534C2050726F7879696E6731243022060355040B0C1B687474703A2F2F636861726C657370726F78792E636F6D2F73736C3111300F060355040A0C08584B3732204C74643111300F06035504070C084175636B6C616E643111300F06035504080C084175636B6C616E64310B3009060355040613024E5A3020180F31383939313233313132303030305A170D3338303932343033313930355A3081913123302106035504030C1A436861726C65732050726F78792053534C2050726F7879696E6731243022060355040B0C1B687474703A2F2F636861726C657370726F78792E636F6D2F73736C3111300F060355040A0C08584B3732204C74643111300F06035504070C084175636B6C616E643111300F06035504080C084175636B6C616E64310B3009060355040613024E5A30820122300D06092A864886F70D01010105000382010F003082010A02820101008349587455EFB272E397A31D3B52D9B13115C93F320766D2D451117F45C40285506027079ED439CABB94D44F1AE136EB1E79BF77ABE43345AD1D436809CF9E035C439272F3CA917DCADD7FBD0E3929F1A345F0B89096130BBD116F8D3AB5655789B7B0831325BD22903F198DA6BDDA30C08DFD17CE9AB51C48555264307BCF789A2B6C48DF4ECAF3EA2C092EE737AD8F397900AC03303BFE2AE43549030A7866CB6FE9B04B9F6EC498B4E7369E99B45491BF093858A77C72F8ADC818E018D413265E39446BE514F78EB57A23AA88F630776F861A9163E04AD38EE8A5C9219D0FC23F6B9A6324455DEA6F4A6A251ECA1FA3D6288CB89FD12A2062A3A015A56F250203010001A381BC3081B9300F0603551D130101FF040530030101FF307706096086480186F842010D046A136853534C2050726F7879696E6720697320656E61626C656420696E20436861726C65732050726F78792E20506C6561736520766973697420687474703A2F2F636861726C657370726F78792E636F6D2F73736C20666F72206D6F726520696E666F726D6174696F6E2E300E0603551D0F0101FF040403020204301D0603551D0E04160414BB27F4CB2EB6DBB058101BBD803F38D208D76129300D06092A864886F70D010105050003820101000041F935F30B209E56360F7E3D9C30314A213323C47EDCEA1467600A50FFE4E8E39DFCA8C8D34463C34745FF04C870F1DF28BB772DB0CF1BCA677B70842C742BC6D5FB00559AD643C6BF2C95BD0B855A961D7D6A3EADA9C642E9A789474C4AD838C6F732D8D859548D30829DF7A32D098FE3F00147DAF08C0B37DD597184C1E27A61EA42050C73994E809013CB21E37BF84BF923BCEFEA6164FD28AB9058CCC48F1F486FC1C47EBD8A9C933F542401B11F36A003E47B141A41C7B326D18D023E11EDB445699AA44800254EA33F174FD5EB1CCCE6A09365751FF905988C06315B5575067BF65EC24CAD1A6A601846D1D2F51F1F420A2762990B044000619D1C84');
EOF
    fi
}

sim-install-certs() {
    for SQLITEDBPATH in ~/Library/Application\ Support/iPhone\ Simulator/*/Library/Keychains/TrustStore.sqlite3; do
	echo $SQLITEDBPATH
	_install-cert
    done

    echo "The Charles SSL CA Certificate has been installed for the iPhone Simulator"
}

export PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[35m\]$(__git_ps1 " (%s)")\[\033[m\]\$ '


    