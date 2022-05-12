(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strConfigIni: string =
    '[fano]' + LineEnding +
    'appName=[[APP_NAME]]' + LineEnding +
    'baseUrl=[[BASE_URL]]' + LineEnding +
    'secretKey=[[SECRET_KEY]]' + LineEnding +
    '[session]' + LineEnding +
    'name=[[SESSION_NAME]]' + LineEnding +
    'dir=[[SESSION_DIR]]' + LineEnding +
    '[cookie]' + LineEnding +
    'name=[[COOKIE_NAME]]' + LineEnding +
    'domain=[[COOKIE_DOMAIN]]' + LineEnding +
    'maxAge=[[COOKIE_MAX_AGE]]' + LineEnding;
