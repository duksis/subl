# Installer for Sublime text 2 on MacOS X

## What it does:
 1. Installs Sublime
 2. Creates a symlink to `~/bin/subl` for easy sublime usage from terminal
 3. Configures sublime with provided or default configuration
 4. Installs Package Control

### Install with
`./install.sh ` # to use my predefined [sublime settings][1]

  or

`./install.sh --configure <PATH TO SUBLIME USER CONFIG DIR> # to use your own sublime configuration`

### Uninstall with
`./uninstall.sh`

## Dependencies
Runtime:

 * *[Git][2]* for cloning sublime settings repository

Development:

 * *[assert.sh][3]* for testing

## License
(The MIT License)

Copyright &copy; 2012 Hugo Duksis. See [LICENSE](LICENSE) file for more details.

[1]: http://github.com/duksis/sublime-settings "Sublime settings"
[2]: http://git-scm.com "Git"
[3]: https://github.com/lehmannro/assert.sh "assert.sh"