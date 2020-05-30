(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strHtaccessExampleInc: string =
    'DirectoryIndex app.cgi' + LineEnding +
    '<IfModule mod_rewrite.c>' + LineEnding +
    '    RewriteEngine On' + LineEnding +
    '' + LineEnding +
    '    # redirect http to https' + LineEnding +
    '    # RewriteCond %{HTTPS} off' + LineEnding +
    '    # RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]' + LineEnding +
    '' + LineEnding +
    '    RewriteCond %{REQUEST_FILENAME} !-d' + LineEnding +
    '    RewriteCond %{REQUEST_FILENAME} !-f' + LineEnding +
    '    RewriteRule ^(.*)$ app.cgi [L]' + LineEnding +
    '</IfModule>';
