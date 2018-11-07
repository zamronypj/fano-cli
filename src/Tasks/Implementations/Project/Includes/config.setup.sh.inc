strConfigSetupSh: string =
    '#------------------------------------------------------------' + LineEnding +
    '# Fano Web Framework Skeleton Application (https://fanoframework.github.io)' + LineEnding +
    '#' + LineEnding +
    '# @link      https://github.com/fanoframework/fano-app' + LineEnding +
    '# @copyright Copyright (c) 2018 Zamrony P. Juhara' + LineEnding +
    '# @license   https://github.com/fanoframework/fano-app/blob/master/LICENSE (GPL 3.0)' + LineEnding +
    '#-------------------------------------------------------------' + LineEnding +
    '#!/bin/bash' + LineEnding +
    '' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '# Scripts to setup configuration files' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'cp app/config/config.json.sample app/config/config.json' + LineEnding +
    'cp build.prod.cfg.sample build.prod.cfg' + LineEnding +
    'cp build.dev.cfg.sample build.dev.cfg' + LineEnding +
    'cp build.cfg.sample build.cfg';
