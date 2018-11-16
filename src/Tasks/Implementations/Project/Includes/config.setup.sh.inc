strConfigSetupSh: string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#--------------------------------------------------------------' + LineEnding +
    '#!/bin/bash' + LineEnding +
    '' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '# Scripts to setup configuration files' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'cp src/config/config.json.sample src/config/config.json' + LineEnding +
    'cp build.prod.cfg.sample build.prod.cfg' + LineEnding +
    'cp build.dev.cfg.sample build.dev.cfg' + LineEnding +
    'cp build.cfg.sample build.cfg';
