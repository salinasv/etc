ulimit -c unlimited

if [ "$PS1" ]; then
	fortune -ac
fi

#Autocompleta solo archivos (No se como jale)
complete -A command man wich whatis wheris info apropos

#Variables necesarias
export PATH=$PATH:/home/salinasv/bin
export MTN_MERGE=meld
export EDITOR=vim

#matlab
export PATH=$PATH:/usr/local/bin
#export MATLAB_JAVA=/opt/java/jre
#export MATLAB_JAVA=/usr/lib/jvm/java-1.6.0-openjdk/jre
#fallback matlab path
export MATLAB_JAVA=/opt/matlab/sys/java/jre/glnx86/jre1.4.2/
export MLM_LICENSE_FILE=/opt/matlab/LICENSE_2.DAT

#modelsim
export PATH=$PATH:~/opt/modeltech/bin
#export LM_LICENSE_FILE=~/opt/modeltech/license.dat
#export LM_LICENSE_FILE=~/George/George/ISE/6sem/Arqui\ III/Lab/license.dat
export MGLS_LICENSE_FILE=28000@10.17.50.56
export LM_LICENSE_FILE=28000@10.17.50.56
#export MGLS_LICENSE_FILE=~/tmp/modelsim/license.dat
#export LM_LICENSE_FILE=~/tmp/modelsim/license.dat
#export MGLS_LICENSE_FILE=28000@127.0.0.1
#export LM_LICENSE_FILE=28000@127.0.0.1
#export CVE_HOME=/home/omar/seamless_5.6/cve_home.ixl
#export MODEL_TECH=/home/salinasv/opt/modeltech
#export export CVE_HOME MODEL_TECH

#Embebidos
export PATH=$PATH:$HOME/bin/Sourcery_G++_Lite/bin
export PATH=$PATH:$HOME/bin/arm-2007q3/bin

#Queremos usar librerías propias (/usr/local/)
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

#Java doesn't like non-re-parenting window managers (awesome). We need to tell
#java that we do not re-parent.
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_AWT_WM_NONREPARENTING=1

# sudo autocomplete
complete -cf sudo

## Para modificar las variables que buscan las bibliotecas, se debe editar
## /etc/ld.so.conf y después correr ldconfig (como root), agregar esto en cada
## nueva instalación.
#para Robocup
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/:/usr/lib/rcssserver3d
#Añadida para xilinx
#export LD_PRELOAD=/home/salinasv/bin/modules/libusb-driver.so

alias ls='ls --color=auto -Fh'
alias grep='grep --color'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias halt='sudo halt'
alias svim='sudo vim'
#alias shutdown='sudo shutdown'
#alias pacman='sudo pacman'
#Para usar vim como 'pager'
alias vmore='vim -u ~/.vim.more -'

# Important commands: Can save your live!
alias isla='echo "Faltan $(( $(( $(date -d 2015-05-09 +%s) - $(date +%s) )) / 60 / 60 / 24 )) dias para la isla."'

#ssh a linux y luego a bacanal
alias ssh-bacanal='ssh -t jvillase@linux.mty.itesm.mx ssh salinasv@10.17.113.113'
alias ssh-operativos='ssh -t jvillase@linux.mty.itesm.mx ssh salinasv@10.17.113.229'
#tunel para licencia de modelsim
alias ssh-modelsim='ssh -f jvillase@linux.mty.itesm.mx -L 28000:10.17.50.56:28000'

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion;
fi

#################Funciones de hacosta##############33
#Estraer archivos
ex () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xvjf $1	;;
			*.tar.gz)	tar xvzf $1	;;
			*.bz2)		bunzip2 $1	;;
			*.rar)		rar x $1	;;
			*.gz)		gunzip $1	;;
			*.tar)		tar xvf $1	;;
			*.tbz2)		tar xvjf $1	;;
			*.tgz)		tar xvzf $1	;;
			*.zip)		unzip $1	;;
			*.Z)		uncompress $1	;;
			*.7z)		7z xv $1	;;
			*)		echo "'$1' cannot be extracted via extract ()"	;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

##Copia y va a la carpeta
cpv () {
	if [ -d "$2" ]; then
		cp $1 $2 && cd $2
	else
		cp $1 $2
	fi
}

##Mueve y va a la capreta
mvv () {
	if [ -d "$2" ]; then
		mv $1 $2 && cd $2
	else
		mv $1 $2
	fi
}
#####################End Funciones de hacosta##############
cp_p()
{
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

#test -n "$DISPLAY" && export TERM=xterm-color

#Try to keep environment pollution down, EPA loves us
unset use_color safe_term

#PS1='[\u@\h \W]\$ '
#PS1='[$?]\[\033[01;32m\]\u@\[\033[01;34m\]\h\w %\[\033[00m\] '
PS1='\[\033[01;37m\][$?]\[\033[01;32m\]\u\[\033[01;31m\]@\[\033[01;34m\]\h \W $(__git_ps1)\[\033[0;37m\]$\[\033[00m\] '
