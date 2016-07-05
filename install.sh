#!/bin/bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    # if $SOURCE was a relative symlink, we need to resolve it relative to
    # the path where the symlink file was located
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
cd $DIR

append ()
{
    if [ -s $2 ] && grep -Fq $1 $2
    then
        echo "$2 already contains the following line; skipping:"
        echo "$1"
    else
        echo "Appending the following line to $2:"
        echo $1
        echo $1 >> $2
    fi
}

mkdir -p $HOME/.config/fish
mkdir -p $HOME/.xmonad
mkdir -p $HOME/bin

append "source $DIR/.profile" $HOME/.profile
append "source $HOME/.profile" $HOME/.bashrc
append "source $DIR/.xinitrc" $HOME/.xinitrc
append "source $DIR/.zshrc" $HOME/.zshrc
append ". $DIR/config.fish" $HOME/.config/fish/config.fish

(
set -x
ln -n -s "$DIR/.xmonad/xmonad.hs" $HOME/.xmonad/xmonad.hs
ln -n -s "$DIR/.xmonad/lib/XMonad/Layout/EqualSpacing.hs" \
    $HOME/.xmonad/lib/XMonad/Layout/EqualSpacing.hs
ln -n -s "$DIR/.vim" $HOME/.config/nvim
ln -n -s "$DIR/.vimrc" $HOME/.config/nvim/init.vim
)

for dotfile in `ls -A | grep "^\." | grep -v -f install.ignore`
do (
    set -x
    ln -n -s $@ "$DIR/$dotfile" $HOME/$dotfile
) done

for userscript in `ls -A $DIR/bin`
do (
    set -x
    ln -n -s $@ "$DIR/bin/$userscript" $HOME/bin/$userscript
) done

cat << EOL

* Some vim plugins left up to manual install.
* Uninstalling dotfiles can be done manually (see above for which things were installed)
EOL
