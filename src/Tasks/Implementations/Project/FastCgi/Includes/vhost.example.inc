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
    '    <Directory "/usr/local/fano/public">' + LineEnding +
    '        Options +ExecCGI' + LineEnding +
    '        AllowOverride FileInfo Indexes' + LineEnding +
    '        Require all granted' + LineEnding +
    '        AddHandler fcgid-script .cgi' + LineEnding +
    '    </Directory>' + LineEnding +
    '</VirtualHost>' + LineEnding +
    '' + LineEnding;
