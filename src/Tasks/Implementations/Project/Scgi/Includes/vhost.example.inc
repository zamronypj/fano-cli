(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strVhostExample: string =
    '<VirtualHost *:80>' + LineEnding +
    '    ProxyRequests Off' + LineEnding +
    '    ProxyPassMatch "/css|js|images|img|plugins|bower_components(.*)|webfonts" !' + LineEnding +
    '    ProxyPassMatch ^/(.*)$ "scgi://fano:7704"' + LineEnding +
    '</VirtualHost>';
