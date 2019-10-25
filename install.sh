#! /bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

# if [[ "$*" == *-n* ]]
# then]
#      >> ~/.profile
# fi

echo "Stowing modules from $(tput bold)module_list$(tput sgr0)..."
set +e
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim | 
set -e
while read module; do
    dir=$(echo $module | awk '{print $1}')
    mod=$(echo $module | awk '{print $2}')
    stow --target=$dir "$mod" && echo "Stowed $(tput bold)$mod$(tput sgr0) to $(tput bold)$dir$(tput sgr0)"
done < module_list

echo "Modules stowed!"

grep -qxF "export CONFIG_DIR=$SCRIPTPATH" ~/.profile || echo -e "\n# AUTOGENERATED\nexport CONFIG_DIR=$SCRIPTPATH" >> ~/.profile && echo "Added CONFIG_DIR to .profile"
# >> ~/.profile; echo "Added .bin to PATH"; }
