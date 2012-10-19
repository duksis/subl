# Installer for Sublime Text 2 on MacOS X

## What it does:
 1. Installs Sublime
 2. Creates a symlink to `~/bin/subl` for easy sublime usage from terminal
 3. Configures sublime with provided or default configuration
 4. Installs Package Control

### Install with

`$ \curl -L raw.github.com/duksis/subl/master/install.sh | CONFIG=~/.config/sublime-text-2 bash`

where `~/.config/sublime-text-2` should be replaced with path to your sublime user directory or git repository url.


### Uninstall with
`$ \curl -L raw.github.com/duksis/subl/master/uninstall.sh | bash`

## Dependencies
Runtime:

 * *[Git][:git]* for cloning sublime settings repository

Development:

 * *[assert.sh][:ash]* for testing

## License
(The MIT License)

Copyright &copy; 2012 Hugo Duksis. See [LICENSE][:lic] file for more details.

[:git]: http://git-scm.com "Git"
[:ash]: https://github.com/lehmannro/assert.sh "assert.sh"
[:lic]: https://github.com/duksis/subl/blob/master/LICENSE "LICENSE"