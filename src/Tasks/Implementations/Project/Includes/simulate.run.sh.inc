strSimulateSh: string = 
    '#------------------------------------------------------------'+#13#10+
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)'+#13#10+
    '#'+#13#10+
    '# @link      https://github.com/fanoframework/fano-app'+#13#10+
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara'+#13#10+
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)'+#13#10+
    '#-------------------------------------------------------------'+#13#10+
    '#!/bin/bash'+#13#10+
    ''+#13#10+
    '#------------------------------------------------------'+#13#10+
    '# Scripts to simulate run CGI app in shell for Linux'+#13#10+
    '#------------------------------------------------------'+#13#10+
    ''+#13#10+
    'CURRDIR=$PWD'+#13#10+
    ''+#13#10+
    '# change current working dir, to simulate how cgi'+#13#10+
    '# app executed by web server'+#13#10+
    'cd app/public'+#13#10+
    ''+#13#10+
    'if [ -z "$REQUEST_METHOD" ]; then'+#13#10+
    '    export REQUEST_METHOD="GET"'+#13#10+
    'fi'+#13#10+
    ''+#13#10+
    'if [ -z "$REQUEST_URI" ]; then'+#13#10+
    '    export REQUEST_URI="/"'+#13#10+
    'fi'+#13#10+
    ''+#13#10+
    './app.cgi'+#13#10+
    ''+#13#10+
    'cd $CURRDIR';
