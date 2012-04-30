#!/bin/bash
#
# Makes softlinks of all the config files under version control in the
# appropriate directories

dir=$(readlink -f $(dirname $0))

cd
for target in $dir/*; do
    # don't copy this install file
    if [[ $(basename $target) != $(basename $0) ]]; then
        linkname="$(basename ${target/dot-/.})"
        # if it already exists (as a regular file, not a link), make a backup
        if [ -f "~/$linkname" ]; then 
            mkdir -p ~/config-backup/
            echo "mv ~/$linkname ~/config-backup/$linkname"
            mv "~/$linkname" "~/config-backup/$linkname"
        fi
        echo "ln -sf ${target/$HOME\//} ${linkname}"
        ln -sf "${target/$HOME\//}" "${linkname}"
    fi
done
source ~/.bashrc

