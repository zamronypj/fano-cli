strSimulateSh: string =
    '#------------------------------------------------------------' + LineEnding +
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    '#' + LineEnding +
    '# @link      https://github.com/fanoframework/fano-app' + LineEnding +
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    '#-------------------------------------------------------------' + LineEnding +
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
    'cd app/public' + LineEnding +
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
