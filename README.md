## My dotfiles

### installation

```sh
git clone https://github.com/artofhuman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

### ZSH installation

``` sh
sudo apt-get install zsh
chsh -s /bin/zsh
```

### Vim YouCompleteMe

After setup dotfiles you should compile YouCompleteMe

``` sh
sudo apt-get install python2.7-dev
cd ~/.vim/plugged/YouCompleteMe
./install.py
```

## Enjoy you terminal life ;)
