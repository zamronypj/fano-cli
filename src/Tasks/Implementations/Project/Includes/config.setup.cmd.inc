strConfigSetupCmd: string = 
    'REM------------------------------------------------------------'+#13#10+
    'REM Fano Web Framework Skeleton Application (https://fanoframework.github.io)'+#13#10+
    'REM'+#13#10+
    'REM @link      https://github.com/fanoframework/fano-app'+#13#10+
    'REM @copyright Copyright (c) 2018 Zamrony P. Juhara'+#13#10+
    'REM @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)'+#13#10+
    'REM-------------------------------------------------------------'+#13#10+
    ''+#13#10+
    'REM------------------------------------------------------'+#13#10+
    'REM Scripts to setup configuration files'+#13#10+
    'REM------------------------------------------------------'+#13#10+
    ''+#13#10+
    'copy app\config\config.json.sample app\config\config.json'+#13#10+
    'copy build.prod.cfg.sample build.prod.cfg'+#13#10+
    'copy build.dev.cfg.sample build.dev.cfg'+#13#10+
    'copy build.cfg.sample build.cfg';
