strDockerCompose : string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#--------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    'version: ''3''' + LineEnding +
    'services:' + LineEnding +

    '#-----------------------------------' + LineEnding +
    '# fano web app' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '  fano:' + LineEnding +
    '    build:' + LineEnding +
    '      context: ./docker/fano' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# web server' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '  webserver:' + LineEnding +
    '    build:' + LineEnding +
    '      context: ./docker/nginx' + LineEnding +
    '';
