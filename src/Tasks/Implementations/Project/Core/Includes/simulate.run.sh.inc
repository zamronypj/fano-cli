(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strSimulateSh: string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#--------------------------------------------------------------' + LineEnding +
    '#!/bin/bash' + LineEnding +
    '' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '# Scripts to simulate run CGI app in shell for Linux' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'CURRDIR=$PWD' + LineEnding +
    '' + LineEnding +
    '# change current working dir, to simulate how cgi' + LineEnding +
    '# app executed by web server' + LineEnding +
    'cd public' + LineEnding +
    '' + LineEnding +
    'if [ -z "$REQUEST_METHOD" ]; then' + LineEnding +
    '    export REQUEST_METHOD="GET"' + LineEnding +
    'fi' + LineEnding +
    '' + LineEnding +
    'if [ -z "$REQUEST_URI" ]; then' + LineEnding +
    '    export REQUEST_URI="/"' + LineEnding +
    'fi' + LineEnding +
    '' + LineEnding +
    './app.cgi' + LineEnding +
    '' + LineEnding +
    'cd $CURRDIR';
