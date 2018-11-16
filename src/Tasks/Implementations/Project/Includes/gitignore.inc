strGitignore: string =
    'src/config/config.json' + LineEnding +
    'public/.htaccess' + LineEnding +
    'public/app.cgi' + LineEnding +
    'cgi-bin/app.cgi' + LineEnding +
    'storages/logs/*' + LineEnding +
    '!storages/logs/README.md' + LineEnding +
    'build.cfg' + LineEnding +
    'build.dev.cfg' + LineEnding +
    'build.prod.cfg' + LineEnding +
    'bin/unit/*' + LineEnding +
    '!bin/README.md' + LineEnding +
    '!bin/unit/README.md' + LineEnding +
    'fp.dir';
