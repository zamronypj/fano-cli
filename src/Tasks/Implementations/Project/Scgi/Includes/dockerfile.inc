strDockerfile : string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#--------------------------------------------------------------' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# use Linux Alpine as base' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'FROM alpine' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# Setup default user and its group' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'RUN groupadd -g 999 fano && \ ' + LineEnding +
    '    useradd -r -u 999 -g fano fano' + LineEnding +
    'USER fano' + LineEnding +
    'COPY ./bin/out/ /usr/local/fano' + LineEnding +
    'COPY ./config/ /usr/local/fano/config' + LineEnding +
    'WORKDIR /usr/local/fano' + LineEnding +
    'EXPOSE 9000' + LineEnding +
    'CMD ["/usr/local/fano/app.cgi", "--port=9000"]';
