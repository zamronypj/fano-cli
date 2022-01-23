strDockerfile: string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#------------------------------------------------------------- *)' + LineEnding +
    'FROM httpd:2.4' + LineEnding +
    'RUN apt-get update' + LineEnding +
    'RUN apt-get upgrade' + LineEnding +
    'ADD ./public/ /usr/local/apache2/htdocs/' + LineEnding +
