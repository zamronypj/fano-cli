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
    '# use Apache 2.4 as base' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'FROM httpd:2.4' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# Setup default user and its group' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'RUN groupadd -g 999 fano && \ ' + LineEnding +
    '    useradd -r -u 999 -g fano fano' + LineEnding +
    'USER fano' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# Enable mod_proxy_fcgi mod_rewrite and' + LineEnding +
    '# additional virtual host config' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'RUN sed -i \' + LineEnding +
    '        -e ''s/^#\(LoadModule .*mod_proxy.so\)/\1/'' \' + LineEnding +
    '        -e ''s/^#\(LoadModule .*mod_proxy_scgi.so\)/\1/'' \' + LineEnding +
    '        -e ''s/^#\(LoadModule .*mod_rewrite.so\)/\1/'' \' + LineEnding +
    '        -e ''s/^#\(Include .*httpd-vhosts.conf\)/\1/'' \' + LineEnding +
    '        /usr/local/apache2/conf/httpd.conf' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# set default virtual host config' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'COPY ./vhost.example /usr/local/apache2/conf/extra/httpd-vhosts.conf' + LineEnding +
    '' + LineEnding +
    'COPY ./bin/out/ /usr/local/fano' + LineEnding +
    'COPY ./config/ /usr/local/fano/config' + LineEnding +
    'COPY ./public/ /usr/local/apache2/htdocs' + LineEnding;
