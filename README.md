# Setup Instructions

## Install packer for neovim
```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Install lua-language-server
```bash
git clone  --depth=1 https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --depth 1 --init --recursive
cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
```

## Open init.vim file and call packer main function
```bash
:PackerSync
```
