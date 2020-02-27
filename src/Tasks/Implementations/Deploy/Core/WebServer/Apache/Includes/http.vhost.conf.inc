strHttpVhostConf: string =
    '<VirtualHost *:80>' + LineEnding +
    '' + LineEnding +
    '    ServerAdmin admin@[[SERVER_NAME]]' + LineEnding +
    '    DocumentRoot "[[DOC_ROOT]]"' + LineEnding +
    '' + LineEnding +
    '    ServerName [[SERVER_NAME]]' + LineEnding +
    '    ServerAlias *.[[SERVER_NAME]]' + LineEnding +
    '' + LineEnding +
    '    ErrorLog [[APACHE_LOG_DIR]]/[[SERVER_NAME]]-error.log' + LineEnding +
    '    CustomLog [[APACHE_LOG_DIR]]/[[SERVER_NAME]]-access.log combined' + LineEnding +
    '' + LineEnding +
    '    <Directory "[[DOC_ROOT]]">' + LineEnding +
    '        Options -MultiViews -FollowSymlinks +SymlinksIfOwnerMatch +ExecCGI' + LineEnding +
    '        AllowOverride FileInfo Indexes' + LineEnding +
    '        Require all granted' + LineEnding +
    '    </Directory>' + LineEnding +
    '' + LineEnding +
    '    ProxyRequests Off' + LineEnding +
    '    ProxyPassMatch "/css|js|images|img|plugins|bower_components(.*)" !' + LineEnding +
    '    ProxyPassMatch ^/(.*)$ "http://[[HOST]]:[[PORT]]"' + LineEnding +
    '</VirtualHost>';
