strReadme: string = 
    '# Fano Web Framework Skeleton Application'+#13#10+
    ''+#13#10+
    'Web application skeleton using Fano, Pascal web application framework'+#13#10+
    ''+#13#10+
    '## Requirement'+#13#10+
    ''+#13#10+
    '- [Free Pascal](https://www.freepascal.org/) >= 3.0'+#13#10+
    '- Web Server (Apache, nginx)'+#13#10+
    '- [Fano Web Framework](https://github.com/fanoframework/fano)'+#13#10+
    ''+#13#10+
    '## Installation'+#13#10+
    ''+#13#10+
    '### Build'+#13#10+
    ''+#13#10+
    'Make sure [Free Pascal](https://www.freepascal.org/) is installed. Run'+#13#10+
    ''+#13#10+
    '    $ fpc -i'+#13#10+
    ''+#13#10+
    'If you see something like `Free Pascal Compiler version 3.0.4`,  you are good to go.'+#13#10+
    ''+#13#10+
    'Clone this repository'+#13#10+
    ''+#13#10+
    '    $ git clone git@github.com:zamronypj/fano-app.git --recursive'+#13#10+
    ''+#13#10+
    '`--recursive` is needed so git also pull [Fano](https://github.com/fanoframework/fano) repository.'+#13#10+
    ''+#13#10+
    'If you are missing `--recursive` when you clone, you may find that `fano` directory is empty. In this case run'+#13#10+
    ''+#13#10+
    '    $ git submodule update --init'+#13#10+
    ''+#13#10+
    'To update Fano to its latest commit, run'+#13#10+
    ''+#13#10+
    '    $ git checkout master && git submodule foreach --recursive git pull origin master'+#13#10+
    ''+#13#10+
    'Above command will checkout to `master` branch of this repository and pull latest update from `master` branch of [Fano](https://github.com/fanoframework/fano) repository.'+#13#10+
    ''+#13#10+
    'Copy `*.cfg.sample` to `*.cfg`.'+#13#10+
    'Make adjustment as you need in `build.cfg`, `build.prod.cfg`, `build.dev.cfg`'+#13#10+
    'and run `build.sh` shell script (if you are on Windows, then `build.cmd`).'+#13#10+
    ''+#13#10+
    'These `*.cfg` files contain some Free Pascal compiler switches that you can turn on/off to change how executable is compiled and generated. For complete'+#13#10+
    'explanation on available compiler switches, consult Free Pascal documentation.'+#13#10+
    ''+#13#10+
    'Also copy `app/config/config.json.sample` to `app/config/config.json` and edit'+#13#10+
    'configuration as needed. For example, you may need to change `baseUrl` to match your own base url so JavaScript or CSS stylesheets point to correct URL.'+#13#10+
    ''+#13#10+
    '    $ cp app/config/config.json.sample app/config/config.json'+#13#10+
    '    $ cp build.prod.cfg.sample build.prod.cfg'+#13#10+
    '    $ cp build.dev.cfg.sample build.dev.cfg'+#13#10+
    '    $ cp build.cfg.sample build.cfg'+#13#10+
    '    $ ./build.sh'+#13#10+
    ''+#13#10+
    '`tools/config.setup.sh` shell script is provided to simplify copying those'+#13#10+
    'configuration files. Following shell command is similar to command above.'+#13#10+
    ''+#13#10+
    '    $ ./tools/config.setup.sh'+#13#10+
    '    $ ./build.sh'+#13#10+
    ''+#13#10+
    'By default, it will output binary executable in `app/public` directory.'+#13#10+
    ''+#13#10+
    '### Build for different environment'+#13#10+
    ''+#13#10+
    'To build for different environment, set `BUILD_TYPE` environment variable.'+#13#10+
    ''+#13#10+
    '#### Build for production environment'+#13#10+
    ''+#13#10+
    '    $ BUILD_TYPE=prod ./build.sh'+#13#10+
    ''+#13#10+
    'Build process will use compiler configuration defined in `fano/fano.cfg`, `build.cfg` and `build.prod.cfg`. By default, `build.prod.cfg` contains some compiler switches that will aggressively optimize executable both in speed and size.'+#13#10+
    ''+#13#10+
    '#### Build for development environment'+#13#10+
    ''+#13#10+
    '    $ BUILD_TYPE=dev ./build.sh'+#13#10+
    ''+#13#10+
    'Build process will use compiler configuration defined in `fano/fano.cfg`, `build.cfg` and `build.dev.cfg`.'+#13#10+
    ''+#13#10+
    'If `BUILD_TYPE` environment variable is not set, production environment will be assumed.'+#13#10+
    ''+#13#10+
    '## Change executable output directory'+#13#10+
    ''+#13#10+
    'Compilation will output executable to directory defined in `EXEC_OUTPUT_DIR`'+#13#10+
    'environment variable. By default is `app/public` directory.'+#13#10+
    ''+#13#10+
    '    $ EXEC_OUTPUT_DIR=/path/to/public/dir ./build.sh'+#13#10+
    ''+#13#10+
    '## Change executable name'+#13#10+
    ''+#13#10+
    'Compilation will use executable filename as defined in `EXEC_OUTPUT_NAME`'+#13#10+
    'environment variable. By default is `app.cgi` filename.'+#13#10+
    ''+#13#10+
    '    $ EXEC_OUTPUT_NAME=index.cgi ./build.sh'+#13#10+
    ''+#13#10+
    '## Run'+#13#10+
    ''+#13#10+
    '### Run with a webserver'+#13#10+
    ''+#13#10+
    'Setup a virtual host. Please consult documentation of web server you use.'+#13#10+
    ''+#13#10+
    'For example on Apache,'+#13#10+
    ''+#13#10+
    '```'+#13#10+
    '<VirtualHost *:80>'+#13#10+
    '     ServerName www.example.com'+#13#10+
    '     DocumentRoot /home/example/app/public'+#13#10+
    ''+#13#10+
    '     <Directory "/home/example/app/public">'+#13#10+
    '         Options +ExecCGI'+#13#10+
    '         AllowOverride FileInfo'+#13#10+
    '         Require all granted'+#13#10+
    '         DirectoryIndex app.cgi'+#13#10+
    '         AddHandler cgi-script .cgi'+#13#10+
    '     </Directory>'+#13#10+
    '</VirtualHost>'+#13#10+
    '```'+#13#10+
    'On Apache, you will need to enable CGI module, such as `mod_cgi` or `mod_cgid`. If CGI module not loaded, above virtual host will cause `app.cgi` is downloaded instead of executed.'+#13#10+
    ''+#13#10+
    'For example, on Debian, this will enable `mod_cgi` module.'+#13#10+
    ''+#13#10+
    '```'+#13#10+
    '$ sudo a2enmod cgi'+#13#10+
    '$ sudo systemctl restart apache2'+#13#10+
    '```'+#13#10+
    ''+#13#10+
    'Depending on your server setup, for example, if  you use `.htaccess`, add following code:'+#13#10+
    ''+#13#10+
    '```'+#13#10+
    '<IfModule mod_rewrite.c>'+#13#10+
    '    RewriteEngine On'+#13#10+
    '    RewriteCond %{REQUEST_FILENAME} !-d'+#13#10+
    '    RewriteCond %{REQUEST_FILENAME} !-f'+#13#10+
    '    RewriteRule ^(.*)$ app.cgi [L]'+#13#10+
    '</IfModule>'+#13#10+
    '```'+#13#10+
    'and put `.htaccess` file in same directory as `app.cgi` file (i.e., in `app/public` directory).'+#13#10+
    ''+#13#10+
    'Content of `.htaccess` basically tells Apache to serve existing files/directories directly. For any non-existing files/directories, pass them to our application.'+#13#10+
    ''+#13#10+
    '### Simulate run on command line'+#13#10+
    ''+#13#10+
    '```'+#13#10+
    '$ cd app/public'+#13#10+
    '$ REQUEST_METHOD=GET \'+#13#10+
    '  REQUEST_URI=/test/test \'+#13#10+
    '  SERVER_NAME=juhara.com \'+#13#10+
    '  ./app.cgi'+#13#10+
    '```'+#13#10+
    ''+#13#10+
    '`tools/simulate.run.sh` is bash script that can be used to simplify simulating run'+#13#10+
    'application in shell.'+#13#10+
    ''+#13#10+
    '    $ ./tools/simulate.run.sh'+#13#10+
    ''+#13#10+
    'or to change route to access, set `REQUEST_URI` variable.'+#13#10+
    ''+#13#10+
    '    $ REQUEST_URI=/test/test ./simulate.run.sh'+#13#10+
    ''+#13#10+
    'This is similar to simulating browser requesting this page,for example,'+#13#10+
    ''+#13#10+
    '    $ wget -O- http://[your fano app hostname]/test/test'+#13#10+
    ''+#13#10+
    'However, running using `tools/simulate.run.sh` allows you to view output of `heaptrc`'+#13#10+
    'unit for detecting memory leak (if you enable `-gh` switch in `build.dev.cfg`).'+#13#10+
    ''+#13#10+
    ''+#13#10+
    '## Deployment'+#13#10+
    ''+#13#10+
    'You need to deploy only executable binary and any supporting files such as HTML templates, images, css stylesheets, application config.'+#13#10+
    'Any `pas` or `inc` files or shell scripts is not needed in deployment machine in order application to run.'+#13#10+
    ''+#13#10+
    'So for this repository, you will need to copy `public`, `Templates`, `config`'+#13#10+
    'and `storages` directories to your deployment machine. make sure that'+#13#10+
    '`storages` directory is writable by web server.'+#13#10+
    ''+#13#10+
    '## Known Issues'+#13#10+
    ''+#13#10+
    '### Issue with GNU Linker'+#13#10+
    ''+#13#10+
    'When running `build.sh` script, you may encounter following warning:'+#13#10+
    ''+#13#10+
    '```'+#13#10+
    '/usr/bin/ld: warning: app/public/link.res contains output sections; did you forget -T?'+#13#10+
    '```'+#13#10+
    ''+#13#10+
    'This is known issue between FreePascal and GNU Linker. See'+#13#10+
    '[FAQ: link.res syntax error, or "did you forget -T?"](https://www.freepascal.org/faq.var#unix-ld219)'+#13#10+
    ''+#13#10+
    'However, this warning is minor and can be ignored. It does not affect output executable.'+#13#10+
    ''+#13#10+
    '### Issue with unsynchronized compiled unit with unit source'+#13#10+
    ''+#13#10+
    'Sometime FreePascal can not compile your code because, for example, you deleted a'+#13#10+
    'unit source code (.pas) but old generated unit (.ppu, .o, .a files) still there'+#13#10+
    'or when you switch between git branches. Solution is to remove those files.'+#13#10+
    ''+#13#10+
    'By default, generated compiled units are in `bin/unit` directory.'+#13#10+
    'But do not delete `README.md` file inside this directory, as it is not being ignored by git.'+#13#10+
    ''+#13#10+
    '```'+#13#10+
    '$ rm bin/unit/*.ppu'+#13#10+
    '$ rm bin/unit/*.o'+#13#10+
    '$ rm bin/unit/*.rsj'+#13#10+
    '$ rm bin/unit/*.a'+#13#10+
    '```'+#13#10+
    ''+#13#10+
    'Following shell command will remove all files inside `bin/unit` directory except'+#13#10+
    '`README.md` file.'+#13#10+
    ''+#13#10+
    '    $ find bin/unit ! -name ''README.md'' -type f -exec rm -f {} +'+#13#10+
    ''+#13#10+
    '`tools/clear.compiled.units.sh` script is provided to simplify this task.'+#13#10+
    ''+#13#10+
    '### Windows user'+#13#10+
    ''+#13#10+
    'Free Pascal supports Windows as target operating system, however, this repository is not yet tested on Windows. To target Windows, in `build.cfg` replace'+#13#10+
    'compiler switch `-Tlinux` with `-Twin64` and uncomment line `#-WC` to'+#13#10+
    'become `-WC`.'+#13#10+
    ''+#13#10+
    '### Lazarus user'+#13#10+
    ''+#13#10+
    'While you can use Lazarus IDE, it is not mandatory tool. Any text editor for code editing (Atom, Visual Studio Code, Sublime, Vim etc) should suffice.';
