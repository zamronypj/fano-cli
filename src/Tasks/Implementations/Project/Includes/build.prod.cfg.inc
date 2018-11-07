strBuildCfgProd: string = 
    '#------------------------------------------------------------'+#13#10+
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)'+#13#10+
    '#'+#13#10+
    '# @link      https://github.com/fanoframework/fano-app'+#13#10+
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara'+#13#10+
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)'+#13#10+
    '#-------------------------------------------------------------'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# User configuration for production build'+#13#10+
    '# Please see FreePascal Documentation for available'+#13#10+
    '# compiler switch configurations'+#13#10+
    '#----------------------------------------------'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# halt compiler after error'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-Se'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Level 3 optimization'+#13#10+
    '# Other available switch -O1, -O2, -O4'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-O3'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Move frequent-used variable in register'+#13#10+
    '# This switch is actually redundant as this'+#13#10+
    '# already be covered by -O3 switch above.'+#13#10+
    '# It puts here just for completeness.'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-Ooregvar'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Removing the calculation of dead values optimization'+#13#10+
    '# this optimization is included in -O4'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-Oodeadvalues'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Use smart linking'+#13#10+
    '# Tell linker to only link symbols that your code'+#13#10+
    '# actually need to reduce executable size'+#13#10+
    '# @link: https://www.freepascal.org/docs-html/prog/progse30.html'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-CX'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Link with smartlinked units'+#13#10+
    '# This is related to -CX switch above, If you enable'+#13#10+
    '# smart linking then smart linking process will only'+#13#10+
    '# be carried out if this switch is enable'+#13#10+
    '# @link: https://www.freepascal.org/docs-html/prog/progse30.html'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-XX'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Strip all debug information and symbols'+#13#10+
    '# from output executable'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-Xs';
