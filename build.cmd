REM------------------------------------------------------------
REM Fano CLI Application (https://fanoframework.github.io)
REM
REM @link      https://github.com/fanoframework/fano-cli
REM @copyright Copyright (c) 2018 Zamrony P. Juhara
REM @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
REM-------------------------------------------------------------

REM ------------------------------------
REM -- build script for Windows
REM ------------------------------------


IF NOT DEFINED BUILD_TYPE (SET BUILD_TYPE="prod")
IF NOT DEFINED UNIT_OUTPUT_DIR (SET UNIT_OUTPUT_DIR="bin\unit")
IF NOT DEFINED EXEC_OUTPUT_DIR (SET EXEC_OUTPUT_DIR="bin\out")

fpc @build.cfg src/fanocli.pas
