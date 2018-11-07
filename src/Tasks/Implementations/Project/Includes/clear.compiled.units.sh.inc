strClearUnitsSh: string = 
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
    '# Scripts to delete all compiled unit files'+#13#10+
    '#------------------------------------------------------'+#13#10+
    ''+#13#10+
    'find bin/unit ! -name ''README.md'' -type f -exec rm -f {} +';
