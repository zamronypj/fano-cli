strBuildCfgProd: string =
    '#------------------------------------------------------------' + LineEnding +
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    '#' + LineEnding +
    '# @link      https://github.com/fanoframework/fano-app' + LineEnding +
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    '#-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# User configuration for production build' + LineEnding +
    '# Please see FreePascal Documentation for available' + LineEnding +
    '# compiler switch configurations' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# halt compiler after error' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Se' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Level 3 optimization' + LineEnding +
    '# Other available switch -O1, -O2, -O4' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-O3' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Move frequent-used variable in register' + LineEnding +
    '# This switch is actually redundant as this' + LineEnding +
    '# already be covered by -O3 switch above.' + LineEnding +
    '# It puts here just for completeness.' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Ooregvar' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Removing the calculation of dead values optimization' + LineEnding +
    '# this optimization is included in -O4' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Oodeadvalues' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Use smart linking' + LineEnding +
    '# Tell linker to only link symbols that your code' + LineEnding +
    '# actually need to reduce executable size' + LineEnding +
    '# @link: https://www.freepascal.org/docs-html/prog/progse30.html' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-CX' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Link with smartlinked units' + LineEnding +
    '# This is related to -CX switch above, If you enable' + LineEnding +
    '# smart linking then smart linking process will only' + LineEnding +
    '# be carried out if this switch is enable' + LineEnding +
    '# @link: https://www.freepascal.org/docs-html/prog/progse30.html' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-XX' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Strip all debug information and symbols' + LineEnding +
    '# from output executable' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Xs';
