strBuildCfg: string = 
    '#------------------------------------------------------------'+#13#10+
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)'+#13#10+
    '#'+#13#10+
    '# @link      https://github.com/fanoframework/fano-app'+#13#10+
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara'+#13#10+
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)'+#13#10+
    '#-------------------------------------------------------------'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# User configuration that applies to both'+#13#10+
    '# development and production environment'+#13#10+
    '# Please see FreePascal Documentation for available'+#13#10+
    '# compiler configurations'+#13#10+
    '#----------------------------------------------'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Target OS'+#13#10+
    '# linux : Linux'+#13#10+
    '# win64 : Windows (not tested yet)'+#13#10+
    '# freebsd : FreeBSD (not tested yet)'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-Tlinux'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Output Windows console application'+#13#10+
    '#'+#13#10+
    '# Uncomment if target OS is Windows'+#13#10+
    '#----------------------------------------------'+#13#10+
    '#-WC'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Target CPU'+#13#10+
    '# x86_64 : Intel 64-bit architecture (default)'+#13#10+
    '# i386 : Intel 32-bit architecture'+#13#10+
    '#----------------------------------------------'+#13#10+
    '#-Px86_64'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Application Unit search path'+#13#10+
    '# USER_APP_DIR is contains user application base directory'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-Fu$USER_APP_DIR$/Dependencies'+#13#10+
    '-Fu$USER_APP_DIR$/Routes'+#13#10+
    '-Fu$USER_APP_DIR$/App/Hello/Controllers'+#13#10+
    '-Fu$USER_APP_DIR$/App/Hello/Controllers/Factories'+#13#10+
    '-Fu$USER_APP_DIR$/App/Hello/Views'+#13#10+
    '-Fu$USER_APP_DIR$/App/Hi/Controllers'+#13#10+
    '-Fu$USER_APP_DIR$/App/Hi/Controllers/Factories'+#13#10+
    '#-Fu$USER_APP_DIR$/path/to/other/units'+#13#10+
    '#-Fu$USER_APP_DIR$/path/to/other/units'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Application include search path'+#13#10+
    '# USER_APP_DIR is contains user application base directory'+#13#10+
    '#----------------------------------------------'+#13#10+
    '-Fi$USER_APP_DIR$/Dependencies'+#13#10+
    '-Fi$USER_APP_DIR$/Routes/home'+#13#10+
    '#-Fu$USER_APP_DIR$/path/to/other/include/files'+#13#10+
    ''+#13#10+
    '#----------------------------------------------'+#13#10+
    '# Include configuration based on build type (default is prod)'+#13#10+
    '# using #INCLUDE directive'+#13#10+
    '# For example'+#13#10+
    '# $ BUILD_TYPE=prod ./build.sh'+#13#10+
    '#----------------------------------------------'+#13#10+
    '#INCLUDE build.$BUILD_TYPE$.cfg';
