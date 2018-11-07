strConfigSetupSh: string = 
    '#------------------------------------------------------------'+#13#10+
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)'+#13#10+
    '#'+#13#10+
    '# @link      https://github.com/fanoframework/fano-app'+#13#10+
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara'+#13#10+
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)'+#13#10+
    '#-------------------------------------------------------------'+#13#10+
    '#!/bin/bash'+#13#10+
    ''+#13#10+
    '#------------------------------------------------------'+#13#10+
    '# Scripts to setup configuration files'+#13#10+
    '#------------------------------------------------------'+#13#10+
    ''+#13#10+
    'cp app/config/config.json.sample app/config/config.json'+#13#10+
    'cp build.prod.cfg.sample build.prod.cfg'+#13#10+
    'cp build.dev.cfg.sample build.dev.cfg'+#13#10+
    'cp build.cfg.sample build.cfg';
