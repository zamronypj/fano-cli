strBuildCmd: string =
    'REM------------------------------------------------------------' + LineEnding +
    'REM [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    'REM' + LineEnding +
    'REM @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    'REM @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    'REM @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    'REM-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'REM ------------------------------------' + LineEnding +
    'REM -- build script for Windows' + LineEnding +
    'REM ------------------------------------' + LineEnding +
    '' + LineEnding +
    'SET FANO_DIR="vendor/fano"' + LineEnding +
    '' + LineEnding +
    'IF NOT DEFINED BUILD_TYPE (SET BUILD_TYPE="prod")' + LineEnding +
    'IF NOT DEFINED USER_APP_DIR (SET USER_APP_DIR="src")' + LineEnding +
    'IF NOT DEFINED UNIT_OUTPUT_DIR (SET UNIT_OUTPUT_DIR="bin\unit")' + LineEnding +
    'IF NOT DEFINED EXEC_OUTPUT_DIR (SET EXEC_OUTPUT_DIR="public")' + LineEnding +
    'IF NOT DEFINED EXEC_OUTPUT_NAME (SET EXEC_OUTPUT_NAME="app.cgi")' + LineEnding +
    'IF NOT DEFINED SOURCE_PROGRAM_NAME (SET SOURCE_PROGRAM_NAME="app.pas")' + LineEnding +
    '' + LineEnding +
    'fpc @vendor/fano/fano.cfg @build.cfg %USER_APP_DIR%\%SOURCE_PROGRAM_NAME%';
