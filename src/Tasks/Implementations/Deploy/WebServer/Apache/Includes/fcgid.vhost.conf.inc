strFcgidVhostConf: string =
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
    '        AddHandler fcgid-script .cgi' + LineEnding +
    '        DirectoryIndex app.cgi' + LineEnding +
    '' + LineEnding +
    '        <IfModule mod_rewrite.c>' + LineEnding +
    '            RewriteEngine On' + LineEnding +
    '' + LineEnding +
    '            # redirect http to https' + LineEnding +
    '            # RewriteCond %{HTTPS} off' + LineEnding +
    '            # RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]' + LineEnding +
    '' + LineEnding +
    '            RewriteCond %{REQUEST_FILENAME} !-d' + LineEnding +
    '            RewriteCond %{REQUEST_FILENAME} !-f' + LineEnding +
    '            RewriteRule ^(.*)$ app.cgi [L]' + LineEnding +
    '        </IfModule>' + LineEnding +
    '' + LineEnding +
    '    </Directory>' + LineEnding +
    '' + LineEnding +
    '</VirtualHost>';