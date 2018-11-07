strBuildSh: string =
    '#------------------------------------------------------------' + LineEnding +
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    '#' + LineEnding +
    '# @link      https://github.com/fanoframework/fano-app' + LineEnding +
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    '#-------------------------------------------------------------' + LineEnding +
    '#!/bin/bash' + LineEnding +
    '' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '# Build script for Linux' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'export FANO_DIR="fano"' + LineEnding +
    '' + LineEnding +
    'if [[ -z "${BUILD_TYPE}" ]]; then' + LineEnding +
    'export BUILD_TYPE="prod"' + LineEnding +
    'fi' + LineEnding +
    '' + LineEnding +
    'if [[ -z "${USER_APP_DIR}" ]]; then' + LineEnding +
    'export USER_APP_DIR="app"' + LineEnding +
    'fi' + LineEnding +
    '' + LineEnding +
    'if [[ -z "${UNIT_OUTPUT_DIR}" ]]; then' + LineEnding +
    '    export UNIT_OUTPUT_DIR="bin/unit"' + LineEnding +
    'fi' + LineEnding +
    '' + LineEnding +
    'if [[ -z "${EXEC_OUTPUT_DIR}" ]]; then' + LineEnding +
    'export EXEC_OUTPUT_DIR="app/public"' + LineEnding +
    'fi' + LineEnding +
    '' + LineEnding +
    'if [[ -z "${EXEC_OUTPUT_NAME}" ]]; then' + LineEnding +
    'export EXEC_OUTPUT_NAME="app.cgi"' + LineEnding +
    'fi' + LineEnding +
    '' + LineEnding +
    'if [[ -z "${SOURCE_PROGRAM_NAME}" ]]; then' + LineEnding +
    'SOURCE_PROGRAM_NAME="app.pas"' + LineEnding +
    'fi' + LineEnding +
    '' + LineEnding +
    'fpc @fano/fano.cfg @build.cfg ${USER_APP_DIR}/${SOURCE_PROGRAM_NAME}';
