strGitignore: string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Ignore any application configuration' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    'src/config/config.json' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Ignore Apache any configuration' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    'public/.htaccess' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Ignore generated binary executable' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    'public/app.cgi' + LineEnding +
    'cgi-bin/app.cgi' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Ignore generated log files' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    'storages/logs/*' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Do not ignore README.md' + LineEnding +
    '# This file is provided so Git can create' + LineEnding +
    '# app/storages/logs directory when this repository' + LineEnding +
    '# is cloned.' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '!storages/logs/README.md' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Ignore compiler switches configurations' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    'build.cfg' + LineEnding +
    'build.dev.cfg' + LineEnding +
    'build.prod.cfg' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Ignore all generated compiled units files' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    'bin/unit/*' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Do not ignore README.md' + LineEnding +
    '# This file is provided so Git can create' + LineEnding +
    '# bin/unit directory when this repository' + LineEnding +
    '# is cloned.' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '!bin/README.md' + LineEnding +
    '!bin/unit/README.md' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Ignore FreePascal built-in console IDE generated files' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    'fp.dir' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Ignore Lazarus local files (user-specific info)' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '*.lps';
