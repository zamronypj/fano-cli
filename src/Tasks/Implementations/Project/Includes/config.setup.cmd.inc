strConfigSetupCmd: string =
    'REM------------------------------------------------------------' + LineEnding +
    'REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    'REM' + LineEnding +
    'REM @link      https://github.com/fanoframework/fano-app' + LineEnding +
    'REM @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    'REM @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    'REM-------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    'REM Scripts to setup configuration files' + LineEnding +
    'REM------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'copy app\config\config.json.sample app\config\config.json' + LineEnding +
    'copy build.prod.cfg.sample build.prod.cfg' + LineEnding +
    'copy build.dev.cfg.sample build.dev.cfg' + LineEnding +
    'copy build.cfg.sample build.cfg';
