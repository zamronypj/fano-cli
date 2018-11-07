strBuildCmd: string = 
    'REM------------------------------------------------------------'+#13#10+
    'REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)'+#13#10+
    'REM'+#13#10+
    'REM @link      https://github.com/fanoframework/fano-app'+#13#10+
    'REM @copyright Copyright (c) 2018 Zamrony P. Juhara'+#13#10+
    'REM @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)'+#13#10+
    'REM-------------------------------------------------------------'+#13#10+
    ''+#13#10+
    'REM ------------------------------------'+#13#10+
    'REM -- build script for Windows'+#13#10+
    'REM ------------------------------------'+#13#10+
    ''+#13#10+
    'SET FANO_DIR="fano"'+#13#10+
    ''+#13#10+
    'IF NOT DEFINED BUILD_TYPE (SET BUILD_TYPE="prod")'+#13#10+
    'IF NOT DEFINED USER_APP_DIR (SET USER_APP_DIR="app")'+#13#10+
    'IF NOT DEFINED UNIT_OUTPUT_DIR (SET UNIT_OUTPUT_DIR="bin\unit")'+#13#10+
    'IF NOT DEFINED EXEC_OUTPUT_DIR (SET EXEC_OUTPUT_DIR="app\public")'+#13#10+
    'IF NOT DEFINED EXEC_OUTPUT_NAME (SET EXEC_OUTPUT_NAME="app.cgi")'+#13#10+
    'IF NOT DEFINED SOURCE_PROGRAM_NAME (SET SOURCE_PROGRAM_NAME="app.pas")'+#13#10+
    ''+#13#10+
    'fpc @fano/fano.cfg @build.cfg %USER_APP_DIR%\%SOURCE_PROGRAM_NAME%';
