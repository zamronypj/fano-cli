strClearUnitsCmd: string =
    'REM------------------------------------------------------------' + LineEnding +
    'REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    'REM' + LineEnding +
    'REM @link      https://github.com/fanoframework/fano-app' + LineEnding +
    'REM @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    'REM @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    'REM-------------------------------------------------------------' + LineEnding +
    'REM!/bin/bash' + LineEnding +
    '' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    'REM Scripts to delete all compiled unit files' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'FOR /R bin\unit %i IN (*) DO IF NOT %i == README.md del %i';
