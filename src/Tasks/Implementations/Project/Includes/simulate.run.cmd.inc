strSimulateCmd: string =
    'REM------------------------------------------------------------' + LineEnding +
    'REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    'REM' + LineEnding +
    'REM @link      https://github.com/fanoframework/fano-app' + LineEnding +
    'REM @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    'REM @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    'REM-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    'REM Scripts to simulate run CGI app in shell for Windows' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'SET %CURRDIR%=%cd%' + LineEnding +
    '' + LineEnding +
    'REM change current working dir, to simulate how cgi' + LineEnding +
    'REM app executed by web server' + LineEnding +
    'cd app\public' + LineEnding +
    '' + LineEnding +
    'IF NOT DEFINED REQUEST_METHOD (SET REQUEST_METHOD="GET")' + LineEnding +
    'IF NOT DEFINED REQUEST_URI (SET REQUEST_URI="/")' + LineEnding +
    '' + LineEnding +
    'app.cgi' + LineEnding +
    '' + LineEnding +
    'cd %CURRDIR%';
