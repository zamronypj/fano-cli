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
    '# Enable mod_cgi mod_rewrite and' + LineEnding +
    '# additional virtual host config' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'RUN sed -i \' + LineEnding +
    '        -e ''s/#\(LoadModule .*mod_cgi.so\)/\1/'' \' + LineEnding +
    '        -e ''s/#\(LoadModule .*mod_cgid.so\)/\1/'' \' + LineEnding +
    '        -e ''s/^#\(LoadModule .*mod_rewrite.so\)/\1/'' \' + LineEnding +
    '        -e ''s/^#\(Include .*httpd-vhosts.conf\)/\1/'' \' + LineEnding +
    '        -e ''s/^#ServerName.*/ServerName 172.17.0.2/'' \' + LineEnding +
    '        /usr/local/apache2/conf/httpd.conf' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# set default virtual host config' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'COPY ./vhost.example /usr/local/apache2/conf/extra/httpd-vhosts.conf' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# remove unneeded file' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'RUN rm /usr/local/apache2/htdocs/index.html' + LineEnding +
    '' + LineEnding +
    '#-----------------------------------' + LineEnding +
    '# add all your project required files' + LineEnding +
    '#-----------------------------------' + LineEnding +
    'COPY ./config/ /usr/local/apache2/config' + LineEnding +
    'COPY ./resources/ /usr/local/apache2/resources' + LineEnding +
    'COPY ./storages/ /usr/local/apache2/storages' + LineEnding +
    'COPY ./public/ /usr/local/apache2/htdocs/' + LineEnding +
    'COPY ./public/app.cgi /usr/local/apache2/htdocs/app.cgi' + LineEnding +
    '' + LineEnding;
