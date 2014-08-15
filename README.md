dotvim
======
My cross-platform .vimrc

# Prerequisites
- Git, check that is in your $PATH (or %PATH% in Windows)
- Python, check that is in your $PATH (or %PATH in Windows)
  - For Windows use python x64
- [Ag](https://github.com/ggreer/the_silver_searcher)
  - For Windows you can easily install using [Chocolatey](http://chocolatey.org/)

## Vim 7.4+ compiled with python and ruby

### Mac
- brew install macvim
    - Use `macvim -v` for console vim

### Ubuntu
- Compile from scratch following this [guide](http://zaiste.net/2013/05/compiling_vim_with_ruby_and_python_support_on_ubuntu/)

### Windows
- Use the latest compiled version from [here](http://solar-blogg.blogspot.ca/p/vim-build.html)
    - In that page you have instructions if you want to compile using Visual Studio
- You can use terminal vim in Windows if you want, I recommend:
    - An xterm console with 256 colors support, like [conemu](https://code.google.com/p/conemu-maximus5/)
    - You can have conemu with other good utilities using [cmder](http://bliker.github.io/cmder/)

# Installation
- Copy or symlink .vimrc to your $HOME (or %HOMEPATH% in Windows)
- Run vim, if it doesn't detect vundle package manager, it will install it with
  all the plugins.

# Credits
- https://github.com/fisadev/fisa-vim-config
- https://github.com/garybernhardt/dotfiles
- https://bitbucket.org/sjl/dotfiles/src
- https://github.com/spf13/spf13-vim

