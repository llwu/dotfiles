#!/bin/bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
cd $DIR

#### SOURCING

if [ -f ~/.profile ] && grep -Fq .profile ~/.profile
then
    echo ".profile already configured"
else (
    set -x
    cat << EOL | tee -a ~/.profile
source $DIR/.profile
BASE16_SHELL="$DIR/base16-shell/scripts/\$COLORSCHEME.sh"
[[ -s \$BASE16_SHELL ]] && source \$BASE16_SHELL
EOL
) fi

if [ -f ~/.bashrc ] && grep -Fq .profile ~/.bashrc
then
    echo ".bashrc already configured"
else (
    set -x
    echo "source ~/.profile" >> ~/.bashrc
) fi

if [ -f ~/.xinitrc ] && grep -Fq .xinitrc ~/.xinitrc
then
    echo ".xinitrc already configured"
else (
    set -x
    echo "source $DIR/.xinitrc" >> ~/.xinitrc
) fi

if [ -f ~/.zshrc ] && grep -Fq .zshrc ~/.zshrc
then
    echo ".zshrc already configured"
else (
    set -x
    echo "source $DIR/.zshrc" >> ~/.zshrc
    echo "source $DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
) fi

mkdir -p ~/.config/fish
if [ -f ~/.config/fish/config.fish ] && grep -Fq config.fish ~/.config/fish/config.fish
then
    echo "config.fish already configured"
else (
    set -x
    cat << EOL | tee -a ~/.config/fish/config.fish
. $DIR/config.fish
. $DIR/prompt.fish
if status --is-interactive
    eval sh $DIR/base16-shell/scripts/\$COLORSCHEME.sh
end
EOL
) fi

#### SYMLINKING

mkdir -p ~/.xmonad
mkdir -p ~/bin
mkdir -p ~/.config

(
set -x
ln -s $@ "$DIR/xmonad.hs" ~/.xmonad
ln -s $@ "$DIR/spotify-nowplaying.sh" ~/bin
ln -n -s $@ "$DIR/.vim" ~/.config/nvim
ln -n -s $@ "$DIR/.vimrc" ~/.config/nvim/init.vim
)

for dotfile in `ls -A | grep "^\." | grep -v -f install.ignore`
do (
    set -x
    ln -n -s $@ "$DIR/$dotfile" ~/$dotfile
) done

for dotfile in `ls -A | grep "^\." | grep -v -f install.ignore`
do (
    set -x
    ln -n -s $@ "$DIR/$dotfile" ~/$dotfile
) done

for userscript in `ls -A $DIR/bin`
do (
    set -x
    ln -n -s $@ "$DIR/bin/$userscript" ~/bin/$userscript
) done

cat << EOL

* Some vim plugins left up to manual install.
* Uninstalling dotfiles can be done manually (see above for which things were installed)
EOL
