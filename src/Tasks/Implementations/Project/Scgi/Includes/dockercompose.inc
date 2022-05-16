strDockercompose : string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#--------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'version: "2"' + LineEnding +
    'services:' + LineEnding +
    '    fano:' + LineEnding +
    '        build: ' + LineEnding +
    '            context: .' + LineEnding +
    '            dockerfile: fano_dockerfile' + LineEnding +
    '        ports: ' + LineEnding +
    '            - "7704:7704"' + LineEnding +
    '    apache:' + LineEnding +
    '        build:' + LineEnding +
    '            context: .' + LineEnding +
    '            dockerfile: httpd_dockerfile' + LineEnding +
    '        depends_on:' + LineEnding +
    '            - fano' + LineEnding +
    '' + LineEnding;
