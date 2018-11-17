#------------------------------------------------------------
# Fano CLI Application (https://fanoframework.github.io)
#
# @link      https://github.com/fanoframework/fano-cli
# @copyright Copyright (c) 2018 Zamrony P. Juhara
# @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
#-------------------------------------------------------------
#!/bin/bash

#------------------------------------------------------
# Build script for Linux
#------------------------------------------------------

if [[ -z "${BUILD_TYPE}" ]]; then
export BUILD_TYPE="prod"
fi

if [[ -z "${UNIT_OUTPUT_DIR}" ]]; then
    export UNIT_OUTPUT_DIR="bin/unit"
fi

if [[ -z "${EXEC_OUTPUT_DIR}" ]]; then
export EXEC_OUTPUT_DIR="bin/out"
fi

fpc @unit.search.cfg @build.cfg src/fanocli.pas
