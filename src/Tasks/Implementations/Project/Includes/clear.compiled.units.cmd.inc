strClearUnitsCmd: string = 
    'REM------------------------------------------------------------'+#13#10+
    'REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)'+#13#10+
    'REM'+#13#10+
    'REM @link      https://github.com/fanoframework/fano-app'+#13#10+
    'REM @copyright Copyright (c) 2018 Zamrony P. Juhara'+#13#10+
    'REM @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)'+#13#10+
    'REM-------------------------------------------------------------'+#13#10+
    'REM!/bin/bash'+#13#10+
    ''+#13#10+
    'REM------------------------------------------------------'+#13#10+
    'REM Scripts to delete all compiled unit files'+#13#10+
    'REM------------------------------------------------------'+#13#10+
    ''+#13#10+
    'FOR /R bin\unit %i IN (*) DO IF NOT %i == README.md del %i';
