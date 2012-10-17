# Installer for Sublime Text 2 on MacOS X

## What it does:
 1. Installs Sublime
 2. Creates a symlink to `~/bin/subl` for easy sublime usage from terminal
 3. Configures sublime with provided or default configuration
 4. Installs Package Control

### Install with

`\curl -L raw.github.com/duksis/subl/master/install.sh | CONFIG=~/code/sublime-settings bash -s`

where `~/code/sublime-settings` should be replaced with path to your sublime user directory or git repository url.

In case no configuration will be provided my predefined [sublime settings][1] are going to be used


### Uninstall with
`\curl -L raw.github.com/duksis/subl/master/uninstall.sh | bash -s`

## Dependencies
Runtime:

 * *[Git][2]* for cloning sublime settings repository

Development:

 * *[assert.sh][3]* for testing

## License
(The MIT License)

Copyright &copy; 2012 Hugo Duksis. See [LICENSE][4] file for more details.

[1]: http://github.com/duksis/sublime-settings "Sublime settings"
[2]: http://git-scm.com "Git"
[3]: https://github.com/lehmannro/assert.sh "assert.sh"
[4]: https://github.com/duksis/subl/blob/master/LICENSE "LICENSE"