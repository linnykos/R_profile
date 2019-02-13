alias gs='git status '
alias ga='git add '
alias gaa='git add --all'
alias gb='git branch '
alias gc='git commit --verbose'
alias gd='git diff --cached'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gpush='git push origin '
alias gpull='git pull origin '

alias dbox='cd /Users/kevinlin/Dropbox/Collaboration\ and\ People'
alias smile='cd /Users/kevinlin/Dropbox/important/ && ssh -i orfe_2014_privatekey.pem klsix@smile.princeton.edu'
##
# Your previous /Users/kevinlin/.bash_profile file was backed up as /Users/kevinlin/.bash_profile.macports-saved_2017-08-25_at_10:59:11
##

# MacPorts Installer addition on 2017-08-25_at_10:59:11: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

export JAVA_HOME=`/usr/libexec/java_home`
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/server