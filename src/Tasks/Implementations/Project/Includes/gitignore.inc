strGitignore: string =
    'app/config/config.json' + LineEnding +
    'app/public/.htaccess' + LineEnding +
    'app/public/app.cgi' + LineEnding +
    'app/cgi-bin/app.cgi' + LineEnding +
    'app/storages/logs/*' + LineEnding +
    '!app/storages/logs/README.md' + LineEnding +
    'build.cfg' + LineEnding +
    'build.dev.cfg' + LineEnding +
    'build.prod.cfg' + LineEnding +
    'bin/unit/*' + LineEnding +
    '!bin/README.md' + LineEnding +
    '!bin/unit/README.md' + LineEnding +
    'fp.dir';
