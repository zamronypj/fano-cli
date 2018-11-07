strClearUnitsSh: string =
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
    '# Scripts to delete all compiled unit files' + LineEnding +
    '#------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'find bin/unit ! -name ''README.md'' -type f -exec rm -f {} +';
