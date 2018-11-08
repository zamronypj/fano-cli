strBuildCmd: string =
    'REM------------------------------------------------------------' + LineEnding +
    'REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    'REM' + LineEnding +
    'REM @link      https://github.com/fanoframework/fano-app' + LineEnding +
    'REM @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    'REM @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    'REM-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'REM ------------------------------------' + LineEnding +
    'REM -- build script for Windows' + LineEnding +
    'REM ------------------------------------' + LineEnding +
    '' + LineEnding +
    'SET FANO_DIR="fano"' + LineEnding +
    '' + LineEnding +
    'IF NOT DEFINED BUILD_TYPE (SET BUILD_TYPE="prod")' + LineEnding +
    'IF NOT DEFINED USER_APP_DIR (SET USER_APP_DIR="app")' + LineEnding +
    'IF NOT DEFINED UNIT_OUTPUT_DIR (SET UNIT_OUTPUT_DIR="bin\unit")' + LineEnding +
    'IF NOT DEFINED EXEC_OUTPUT_DIR (SET EXEC_OUTPUT_DIR="app\public")' + LineEnding +
    'IF NOT DEFINED EXEC_OUTPUT_NAME (SET EXEC_OUTPUT_NAME="app.cgi")' + LineEnding +
    'IF NOT DEFINED SOURCE_PROGRAM_NAME (SET SOURCE_PROGRAM_NAME="app.pas")' + LineEnding +
    '' + LineEnding +
    'fpc @fano/fano.cfg @build.cfg %USER_APP_DIR%\%SOURCE_PROGRAM_NAME%';