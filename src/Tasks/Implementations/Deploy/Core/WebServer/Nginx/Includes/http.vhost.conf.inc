strUwsgiVhostConf: string =
    'server {' + LineEnding +
    '' + LineEnding +
    '    listen 80;' + LineEnding +
    '    root [[DOC_ROOT]];' + LineEnding +
    '' + LineEnding +
    '    server_name [[SERVER_NAME]] *.[[SERVER_NAME]];' + LineEnding +
    '' + LineEnding +
    '    error_log [[NGINX_LOG_DIR]]/[[SERVER_NAME]]-error.log;' + LineEnding +
    '    access_log [[NGINX_LOG_DIR]]/[[SERVER_NAME]]-access.log;' + LineEnding +
    '' + LineEnding +
    '    location / {' + LineEnding +
    '        try_files $uri @[[SERVER_NAME]];' + LineEnding +
    '    }' + LineEnding +
    '' + LineEnding +
    '    location @[[SERVER_NAME]] {' + LineEnding +
    '        proxy_pass [[HOST]]:[[PORT]];' + LineEnding +
    '    }' + LineEnding +
    '' + LineEnding +
    '}';
