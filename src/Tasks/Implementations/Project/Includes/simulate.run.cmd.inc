strSimulateCmd: string =
    'REM------------------------------------------------------------' + LineEnding +
    'REM [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    'REM' + LineEnding +
    'REM @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    'REM @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    'REM @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
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
