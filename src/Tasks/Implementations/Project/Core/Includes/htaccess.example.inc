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
