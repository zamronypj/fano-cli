strBuildSh: string = 
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
    '# Build script for Linux'+#13#10+
    '#------------------------------------------------------'+#13#10+
    ''+#13#10+
    'export FANO_DIR="fano"'+#13#10+
    ''+#13#10+
    'if [[ -z "${BUILD_TYPE}" ]]; then'+#13#10+
    'export BUILD_TYPE="prod"'+#13#10+
    'fi'+#13#10+
    ''+#13#10+
    'if [[ -z "${USER_APP_DIR}" ]]; then'+#13#10+
    'export USER_APP_DIR="app"'+#13#10+
    'fi'+#13#10+
    ''+#13#10+
    'if [[ -z "${UNIT_OUTPUT_DIR}" ]]; then'+#13#10+
    '    export UNIT_OUTPUT_DIR="bin/unit"'+#13#10+
    'fi'+#13#10+
    ''+#13#10+
    'if [[ -z "${EXEC_OUTPUT_DIR}" ]]; then'+#13#10+
    'export EXEC_OUTPUT_DIR="app/public"'+#13#10+
    'fi'+#13#10+
    ''+#13#10+
    'if [[ -z "${EXEC_OUTPUT_NAME}" ]]; then'+#13#10+
    'export EXEC_OUTPUT_NAME="app.cgi"'+#13#10+
    'fi'+#13#10+
    ''+#13#10+
    'if [[ -z "${SOURCE_PROGRAM_NAME}" ]]; then'+#13#10+
    'SOURCE_PROGRAM_NAME="app.pas"'+#13#10+
    'fi'+#13#10+
    ''+#13#10+
    'fpc @fano/fano.cfg @build.cfg ${USER_APP_DIR}/${SOURCE_PROGRAM_NAME}';
