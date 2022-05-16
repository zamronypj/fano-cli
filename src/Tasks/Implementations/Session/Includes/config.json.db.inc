(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strConfigJsonDb: string =
    '{' + LineEnding +
    '    "appName" : "[[APP_NAME]]",' + LineEnding +
    '' + LineEnding +
    '    "baseUrl" : "[[BASE_URL]]",' + LineEnding +
    '' + LineEnding +
    '    "secretKey" : "[[SECRET_KEY]]",' + LineEnding +
    '' + LineEnding +
    '    "session" : {' + LineEnding +
    '        "name" : "[[SESSION_NAME]]",' + LineEnding +
    '        "tableName" : "[[SESSION_TABLE]]",' + LineEnding +
    '        "sessionIdColumn" : "[[SESSION_ID_COLUMN]]",' + LineEnding +
    '        "dataColumn" : "[[SESSION_DATA_COLUMN]]",' + LineEnding +
    '        "expiredAtColumn" : "[[SESSION_EXPIRED_AT_COLUMN]]"' + LineEnding +
    '    },' + LineEnding +
    '' + LineEnding +
    '    "cookie" : {' + LineEnding +
    '        "name" : "[[COOKIE_NAME]]",' + LineEnding +
    '        "domain" : "[[COOKIE_DOMAIN]]",' + LineEnding +
    '        "maxAge" : [[COOKIE_MAX_AGE]]' + LineEnding +
    '    },' + LineEnding +
    '    "db" : {' + LineEnding +
    '        "version" : "[[DB_VER]]",' + LineEnding +
    '        "host" : "[[DB_HOST]]",' + LineEnding +
    '        "port" : [[DB_PORT]],' + LineEnding +
    '        "db" : "[[DB_NAME]]",' + LineEnding +
    '        "user" : "[[DB_USER]]",' + LineEnding +
    '        "passw" : "[[DB_PASSW]]"' + LineEnding +
    '    }' + LineEnding +
    '}';
