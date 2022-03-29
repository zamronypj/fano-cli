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
    '# Enable mod_proxy_fcgi mod_rewrite and' + LineEnding +
    '# additional virtual host config' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'RUN sed -i \' + LineEnding +
    '        -e ''s/^#\(LoadModule .*mod_proxy.so\)/\1/'' \' + LineEnding +
    '        -e ''s/^#\(LoadModule .*mod_proxy_fcgi.so\)/\1/'' \' + LineEnding +
    '        -e ''s/^#\(LoadModule .*mod_rewrite.so\)/\1/'' \' + LineEnding +
    '        -e ''s/^#\(Include .*httpd-vhosts.conf\)/\1/'' \' + LineEnding +
    '        /usr/local/apache2/conf/httpd.conf' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# set default virtual host config' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'COPY ./vhost.example /usr/local/apache2/conf/extra/httpd-vhosts.conf' + LineEnding +
    '' + LineEnding +
    'COPY ./bin/app.cgi /usr/local/fano/app.cgi' + LineEnding +
    'COPY ./config/ /usr/local/fano/config' + LineEnding +
    'COPY ./public/ /usr/local/apache2/htdocs' + LineEnding +
    'CMD /usr/local/fano/app.cgi --host=0.0.0.0 --port=7704 & httpd-foreground' + LineEnding;
