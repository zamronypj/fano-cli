strBuildCfg: string =
    '#------------------------------------------------------------' + LineEnding +
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    '#' + LineEnding +
    '# @link      https://github.com/fanoframework/fano-app' + LineEnding +
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    '#-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# User configuration that applies to both' + LineEnding +
    '# development and production environment' + LineEnding +
    '# Please see FreePascal Documentation for available' + LineEnding +
    '# compiler configurations' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Target OS' + LineEnding +
    '# linux : Linux' + LineEnding +
    '# win64 : Windows (not tested yet)' + LineEnding +
    '# freebsd : FreeBSD (not tested yet)' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Tlinux' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Output Windows console application' + LineEnding +
    '#' + LineEnding +
    '# Uncomment if target OS is Windows' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '#-WC' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Target CPU' + LineEnding +
    '# x86_64 : Intel 64-bit architecture (default)' + LineEnding +
    '# i386 : Intel 32-bit architecture' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '#-Px86_64' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Application Unit search path' + LineEnding +
    '# USER_APP_DIR is contains user application base directory' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Fu$USER_APP_DIR$/Dependencies' + LineEnding +
    '-Fu$USER_APP_DIR$/Routes' + LineEnding +
    '-Fu$USER_APP_DIR$/App/Hello/Controllers' + LineEnding +
    '-Fu$USER_APP_DIR$/App/Hello/Controllers/Factories' + LineEnding +
    '-Fu$USER_APP_DIR$/App/Hello/Views' + LineEnding +
    '-Fu$USER_APP_DIR$/App/Hi/Controllers' + LineEnding +
    '-Fu$USER_APP_DIR$/App/Hi/Controllers/Factories' + LineEnding +
    '#-Fu$USER_APP_DIR$/path/to/other/units' + LineEnding +
    '#-Fu$USER_APP_DIR$/path/to/other/units' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Application include search path' + LineEnding +
    '# USER_APP_DIR is contains user application base directory' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '-Fi$USER_APP_DIR$/Dependencies' + LineEnding +
    '-Fi$USER_APP_DIR$/Routes/home' + LineEnding +
    '#-Fu$USER_APP_DIR$/path/to/other/include/files' + LineEnding +
    '' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '# Include configuration based on build type (default is prod)' + LineEnding +
    '# using #INCLUDE directive' + LineEnding +
    '# For example' + LineEnding +
    '# $ BUILD_TYPE=prod ./build.sh' + LineEnding +
    '#----------------------------------------------' + LineEnding +
    '#INCLUDE build.$BUILD_TYPE$.cfg';
