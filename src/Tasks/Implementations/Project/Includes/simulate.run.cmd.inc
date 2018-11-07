strSimulateCmd: string = 
    'REM------------------------------------------------------------'+#13#10+
    'REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)'+#13#10+
    'REM'+#13#10+
    'REM @link      https://github.com/fanoframework/fano-app'+#13#10+
    'REM @copyright Copyright (c) 2018 Zamrony P. Juhara'+#13#10+
    'REM @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)'+#13#10+
    'REM-------------------------------------------------------------'+#13#10+
    ''+#13#10+
    'REM------------------------------------------------------'+#13#10+
    'REM Scripts to simulate run CGI app in shell for Windows'+#13#10+
    'REM------------------------------------------------------'+#13#10+
    ''+#13#10+
    'SET %CURRDIR%=%cd%'+#13#10+
    ''+#13#10+
    'REM change current working dir, to simulate how cgi'+#13#10+
    'REM app executed by web server'+#13#10+
    'cd app\public'+#13#10+
    ''+#13#10+
    'IF NOT DEFINED REQUEST_METHOD (SET REQUEST_METHOD="GET")'+#13#10+
    'IF NOT DEFINED REQUEST_URI (SET REQUEST_URI="/")'+#13#10+
    ''+#13#10+
    'app.cgi'+#13#10+
    ''+#13#10+
    'cd %CURRDIR%';
