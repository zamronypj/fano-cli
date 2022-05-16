(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strEnv: string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#--------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    '' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '# add any environment variables here. They will be loaded' + LineEnding +
    '# when build script runs.' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    '' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '# Indy base directory' + LineEnding +
    '# Remove # if you want to use Indy library with' + LineEnding +
    '# Fano Framework. Set it to actual path where Indy is.' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '#INDY_DIR="/path/to/indy"' + LineEnding +
    '' + LineEnding +
    '' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '# Synapse base directory' + LineEnding +
    '# Remove # if you want to use Synapse library with' + LineEnding +
    '# Fano Framework. Set it to actual path where Synapse is.' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '#SYNAPSE_DIR="/path/to/synapse"' + LineEnding +
    '' + LineEnding +
    '' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '# LNET base directory' + LineEnding +
    '# Remove # if you want to use LNET library with' + LineEnding +
    '# Fano Framework. Set it to actual path where LNET is.' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '#LNET_DIR="/path/to/lnet"' + LineEnding +
    '' + LineEnding;
