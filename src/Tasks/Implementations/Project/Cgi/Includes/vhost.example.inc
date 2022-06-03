strVhostExample : string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#--------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    '<VirtualHost *:80>' + LineEnding +
    '    <Directory "/usr/local/apache2/htdocs">' + LineEnding +
    '        Options +ExecCGI' + LineEnding +
    '        AllowOverride FileInfo Indexes' + LineEnding +
    '        Require all granted' + LineEnding +
    '        DirectoryIndex app.cgi' + LineEnding +
    '        AddHandler cgi-script .cgi' + LineEnding +
    '        <IfModule mod_rewrite.c>' + LineEnding +
    '            RewriteEngine On' + LineEnding +
    '' + LineEnding +
    '            RewriteCond %{REQUEST_FILENAME} !-d' + LineEnding +
    '            RewriteCond %{REQUEST_FILENAME} !-f' + LineEnding +
    '            RewriteRule ^(.*)$ app.cgi [L]' + LineEnding +
    '        </IfModule>' + LineEnding +
    '    </Directory>' + LineEnding +
    '</VirtualHost>' + LineEnding +
    '' + LineEnding;
