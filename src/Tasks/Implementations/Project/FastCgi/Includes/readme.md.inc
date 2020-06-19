(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strReadme: string =
    '# Fano Web Framework Skeleton Application' + LineEnding +
    '' + LineEnding +
    'Web application skeleton using Fano Framework, Pascal web application framework' + LineEnding +
    '' + LineEnding +
    'This project is generated using [Fano CLI](https://github.com/fanoframework/fano-cli)' + LineEnding +
    'command line tools to help scaffolding web application using Fano Framework.' + LineEnding +
    '' + LineEnding +
    '## Requirement' + LineEnding +
    '' + LineEnding +
    '- [Free Pascal](https://www.freepascal.org/) >= 3.0' + LineEnding +
    '- [Fano CLI](https://github.com/fanoframework/fano-cli)' + LineEnding +
    '- Web Server (Apache, nginx)' + LineEnding +
    '- Administrative privilege for setting up virtual host' + LineEnding +
    '' + LineEnding +
    '## Installation' + LineEnding +
    '' + LineEnding +
    '### TLDR' + LineEnding +
    'Make sure all requirements are met. Run' + LineEnding +
    '```' + LineEnding +
    '$ git clone https://your-repo-hostname/fano-app.git --recursive' + LineEnding +
    '$ cd fano-app' + LineEnding +
    '$ ./tools/config.setup.sh' + LineEnding +
    '$ ./build.sh' + LineEnding +
    '$ sudo fanocli --deploy-deploy-fcgi=fano-app.fano' + LineEnding +
    '```' + LineEnding +
    'Open internet browser and go to `http://fano-app.fano`. You should see application.' + LineEnding +

    '' + LineEnding +
    '### Free Pascal installation' + LineEnding +
    '' + LineEnding +
    'Make sure [Free Pascal](https://www.freepascal.org/) is installed. Run' + LineEnding +
    '' + LineEnding +
    '    $ fpc -i' + LineEnding +
    '' + LineEnding +
    'If you see something like `Free Pascal Compiler version 3.0.4`,  you are good to go.' + LineEnding +
    '' + LineEnding +
    'Clone this repository' + LineEnding +
    '' + LineEnding +
    '    $ git clone https://your-repo-hostname/fano-app.git --recursive' + LineEnding +
    '' + LineEnding +
    '`--recursive` is needed so git also pull [Fano](https://github.com/fanoframework/fano) repository.' + LineEnding +
    '' + LineEnding +
    'If you are missing `--recursive` when you clone, you may find that `vendor/fano` directory is empty. In this case run' + LineEnding +
    '' + LineEnding +
    '    $ git submodule update --init' + LineEnding +
    '' + LineEnding +
    'To update Fano to its latest commit, run' + LineEnding +
    '' + LineEnding +
    '    $ git checkout master && git submodule foreach --recursive git pull origin master' + LineEnding +
    '' + LineEnding +
    'Above command will checkout to `master` branch of this repository and pull latest update from `master` branch of [Fano](https://github.com/fanoframework/fano) repository.' + LineEnding +
    '' + LineEnding +
    'Copy `*.cfg.sample` to `*.cfg`.' + LineEnding +
    'Make adjustment as you need in `build.cfg`, `build.prod.cfg`, `build.dev.cfg`' + LineEnding +
    'and run `build.sh` shell script (if you are on Windows, then `build.cmd`).' + LineEnding +
    '' + LineEnding +
    'These `*.cfg` files contain some Free Pascal compiler switches that you can turn on/off to change how executable is compiled and generated. For complete' + LineEnding +
    'explanation on available compiler switches, consult Free Pascal documentation.' + LineEnding +
    '' + LineEnding +
    'Also copy `src/config/config.json.sample` to `src/config/config.json` and edit' + LineEnding +
    'configuration as needed. For example, you may need to change `baseUrl` to match your own base url so JavaScript or CSS stylesheets point to correct URL.' + LineEnding +
    '' + LineEnding +
    '    $ cp config/config.json.sample config/config.json' + LineEnding +
    '    $ cp build.prod.cfg.sample build.prod.cfg' + LineEnding +
    '    $ cp build.dev.cfg.sample build.dev.cfg' + LineEnding +
    '    $ cp build.cfg.sample build.cfg' + LineEnding +
    '    $ ./build.sh' + LineEnding +
    '' + LineEnding +
    '`tools/config.setup.sh` shell script is provided to simplify copying those' + LineEnding +
    'configuration files. Following shell command is similar to command above.' + LineEnding +
    '' + LineEnding +
    '    $ ./tools/config.setup.sh' + LineEnding +
    '    $ ./build.sh' + LineEnding +
    '' + LineEnding +
    'By default, it will output binary executable in `public` directory.' + LineEnding +
    '' + LineEnding +
    '### Build for different environment' + LineEnding +
    '' + LineEnding +
    'To build for different environment, set `BUILD_TYPE` environment variable.' + LineEnding +
    '' + LineEnding +
    '#### Build for production environment' + LineEnding +
    '' + LineEnding +
    '    $ BUILD_TYPE=prod ./build.sh' + LineEnding +
    '' + LineEnding +
    'Build process will use compiler configuration defined in `vendor/fano/fano.cfg`, `build.cfg` and `build.prod.cfg`. By default, `build.prod.cfg` contains some compiler switches that will aggressively optimize executable both in speed and size.' + LineEnding +
    '' + LineEnding +
    '#### Build for development environment' + LineEnding +
    '' + LineEnding +
    '    $ BUILD_TYPE=dev ./build.sh' + LineEnding +
    '' + LineEnding +
    'Build process will use compiler configuration defined in `vendor/fano/fano.cfg`, `build.cfg` and `build.dev.cfg`.' + LineEnding +
    '' + LineEnding +
    'If `BUILD_TYPE` environment variable is not set, production environment will be assumed.' + LineEnding +
    '' + LineEnding +
    '## Change executable output directory' + LineEnding +
    '' + LineEnding +
    'Compilation will output executable to directory defined in `EXEC_OUTPUT_DIR`' + LineEnding +
    'environment variable. By default is `public` directory.' + LineEnding +
    '' + LineEnding +
    '    $ EXEC_OUTPUT_DIR=/path/to/public/dir ./build.sh' + LineEnding +
    '' + LineEnding +
    '## Change executable name' + LineEnding +
    '' + LineEnding +
    'Compilation will use executable filename as defined in `EXEC_OUTPUT_NAME`' + LineEnding +
    'environment variable. By default is `app.cgi` filename.' + LineEnding +
    '' + LineEnding +
    '    $ EXEC_OUTPUT_NAME=index.cgi ./build.sh' + LineEnding +
    '' + LineEnding +
    '## Run' + LineEnding +
    '' + LineEnding +
    '### Run with a webserver' + LineEnding +
    '' + LineEnding +
    'Setup a virtual host. Please consult documentation of web server you use.' + LineEnding +
    '' + LineEnding +
    '#### Apache' + LineEnding +
    '' + LineEnding +
    'You need to have `mod_proxy_fcgi` installed and loaded. This module is Apache''s built-in module, so it is very likely that you will have it with your Apache installation. You just need to make sure it is loaded. For example, on Debian,' + LineEnding +
    '' + LineEnding +
    '```' + LineEnding +
    '$ sudo a2enmod proxy_fcgi' + LineEnding +
    '$ sudo systemctl restart apache2' + LineEnding +
    '```' + LineEnding +
    '' + LineEnding +
    'Create virtual host config and add `ProxyPassMatch`, for example' + LineEnding +
    '' + LineEnding +
    '```' + LineEnding +
    '<VirtualHost *:80>' + LineEnding +
    '     ServerName www.example.com' + LineEnding +
    '     DocumentRoot /home/example/public' + LineEnding +
    '' + LineEnding +
    '     <Directory "/home/example/public">' + LineEnding +
    '         Options +ExecCGI' + LineEnding +
    '         AllowOverride FileInfo' + LineEnding +
    '         Require all granted' + LineEnding +
    '     </Directory>' + LineEnding +
    '' + LineEnding +
    '    ProxyRequests Off' + LineEnding +
    '    ProxyPass /css !' + LineEnding +
    '    ProxyPass /images !' + LineEnding +
    '    ProxyPass /js !' + LineEnding +
    '    ProxyPassMatch ^/(.*)$ fcgi://127.0.0.1:20477' + LineEnding +
    '</VirtualHost>' + LineEnding +
    '```' + LineEnding +
    'Last four line of virtual host configurations basically tell Apache to serve any' + LineEnding +
    'files inside `css`, `images`, `js` directly otherwise pass it to our application.' + LineEnding +
    '' + LineEnding +
    'On Debian, save it to `/etc/apache2/sites-available` for example as `fano-scgi.conf`' + LineEnding +
    'Enable this site and restart Apache' + LineEnding +
    '' + LineEnding +
    '```' + LineEnding +
    '$ sudo a2ensite fano-fcgi.conf' + LineEnding +
    '$ sudo systemctl restart apache2' + LineEnding +
    '```' + LineEnding +
    '## Deployment' + LineEnding +
    '' + LineEnding +
    'You need to deploy only executable binary and any supporting files such as HTML templates, images, css stylesheets, application config.' + LineEnding +
    'Any `pas` or `inc` files or shell scripts is not needed in deployment machine in order application to run.' + LineEnding +
    '' + LineEnding +
    'So for this repository, you will need to copy `public`, `Templates`, `config`' + LineEnding +
    'and `storages` directories to your deployment machine. make sure that' + LineEnding +
    '`storages` directory is writable by web server.' + LineEnding +
    '' + LineEnding +
    '## Known Issues' + LineEnding +
    '' + LineEnding +
    '### Issue with GNU Linker' + LineEnding +
    '' + LineEnding +
    'When running `build.sh` script, you may encounter following warning:' + LineEnding +
    '' + LineEnding +
    '```' + LineEnding +
    '/usr/bin/ld: warning: public/link.res contains output sections; did you forget -T?' + LineEnding +
    '```' + LineEnding +
    '' + LineEnding +
    'This is known issue between Free Pascal and GNU Linker. See' + LineEnding +
    '[FAQ: link.res syntax error, or "did you forget -T?"](https://www.freepascal.org/faq.var#unix-ld219)' + LineEnding +
    '' + LineEnding +
    'However, this warning is minor and can be ignored. It does not affect output executable.' + LineEnding +
    '' + LineEnding +
    '### Issue with unsynchronized compiled unit with unit source' + LineEnding +
    '' + LineEnding +
    'Sometime Free Pascal can not compile your code because, for example, you deleted a' + LineEnding +
    'unit source code (.pas) but old generated unit (.ppu, .o, .a files) still there' + LineEnding +
    'or when you switch between git branches. Solution is to remove those files.' + LineEnding +
    '' + LineEnding +
    'By default, generated compiled units are in `bin/unit` directory.' + LineEnding +
    'But do not delete `README.md` file inside this directory, as it is not being ignored by git.' + LineEnding +
    '' + LineEnding +
    '```' + LineEnding +
    '$ rm bin/unit/*.ppu' + LineEnding +
    '$ rm bin/unit/*.o' + LineEnding +
    '$ rm bin/unit/*.rsj' + LineEnding +
    '$ rm bin/unit/*.a' + LineEnding +
    '```' + LineEnding +
    '' + LineEnding +
    'Following shell command will remove all files inside `bin/unit` directory except' + LineEnding +
    '`README.md` file.' + LineEnding +
    '' + LineEnding +
    '    $ find bin/unit ! -name ''README.md'' -type f -exec rm -f {} +' + LineEnding +
    '' + LineEnding +
    '`tools/clean.sh` script is provided to simplify this task.' + LineEnding +
    '' + LineEnding +
    '### Windows user' + LineEnding +
    '' + LineEnding +
    'Free Pascal supports Windows as target operating system, however, this repository is not yet tested on Windows. To target Windows, in `build.cfg` replace' + LineEnding +
    'compiler switch `-Tlinux` with `-Twin64` and uncomment line `#-WC` to' + LineEnding +
    'become `-WC`.' + LineEnding +
    '' + LineEnding +
    '### Lazarus user' + LineEnding +
    '' + LineEnding +
    'While you can use Lazarus IDE, it is not mandatory tool. Any text editor for code editing (Atom, Visual Studio Code, Sublime, Vim etc) should suffice.';
