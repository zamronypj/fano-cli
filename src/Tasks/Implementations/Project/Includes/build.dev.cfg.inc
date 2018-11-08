strBuildCfgDev: string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#--------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# User configuration for development build' + LineEnding +
    '# Please see FreePascal Documentation for available' + LineEnding +
    '# compiler switch configurations' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# halt compiler after error, warning and notes' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Sewn' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Generate debugging information for debugging with gdb.' + LineEnding +
    '# For production, this should be commented out' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-g' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Generate debugging information for debugging with gdb.' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-gl' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Turn on heap trace for checking memory leak.' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '#-gh' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Check and assertion for I/O' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Ci' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Check and assertion for range' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Cr' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Check and assertion for overflow' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Co' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Check and assertion for stack' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Ct' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Check and assertion for method call verification' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-CR' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# include assertion code' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Sa' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# verbose for debugging purpose' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-vd' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Verbosity, show errors (e), warning (w), notes (n), hints (h)' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Vewnh' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Verbose unit searching info,' + LineEnding +
    '# Remove comment, in case unit file is not found' + LineEnding +
    '# so FreePascal will output verbose message where' + LineEnding +
    '# it tries to look for unit file' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '#-vut';
