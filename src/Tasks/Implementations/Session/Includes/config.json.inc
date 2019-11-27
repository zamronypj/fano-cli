strConfigJson: string =
    '{' + LineEnding +
    '    "appName" : "[[APP_NAME]]",' + LineEnding +
    '' + LineEnding +
    '    "baseUrl" : "[[BASE_URL]]",' + LineEnding +
    '' + LineEnding +
    '    "secretKey" : "[[SECRET_KEY]]",' + LineEnding +
    '' + LineEnding +
    '    "session" : {' + LineEnding +
    '        "name" : "[[SESSION_NAME]]",' + LineEnding +
    '        "dir" : "[[SESSION_DIR]]"' + LineEnding +
    '    },' + LineEnding +
    '' + LineEnding +
    '    "cookie" : {' + LineEnding +
    '        "name" : "[[COOKIE_NAME]]",' + LineEnding +
    '        "domain" : "[[COOKIE_DOMAIN]]",' + LineEnding +
    '        "maxAge" : [[COOKIE_MAX_AGE]]' + LineEnding +
    '    }' + LineEnding +
    '}';
