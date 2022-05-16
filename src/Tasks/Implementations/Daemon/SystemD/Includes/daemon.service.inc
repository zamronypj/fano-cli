(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
strDaemonServiceInc: string =
    '#------------------------------------------------------------' + LineEnding +
    '# [[APP_NAME]] ([[APP_URL]])' + LineEnding +
    '#' + LineEnding +
    '# @link      [[APP_REPOSITORY_URL]]' + LineEnding +
    '# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]' + LineEnding +
    '# @license   [[LICENSE_URL]] ([[LICENSE]])' + LineEnding +
    '#------------------------------------------------------------- ' + LineEnding +

    '[Unit]' + LineEnding +
    'Description=[[APP_NAME]]' + LineEnding +
    'After=network.target' + LineEnding +
    'StartLimitIntervalSec=0' + LineEnding +
    '' + LineEnding +
    '[Service]' + LineEnding +
    'Type=simple' + LineEnding +
    'Restart=always' + LineEnding +
    'RestartSec=1' + LineEnding +
    'User=[[USER]]' + LineEnding +
    'ExecStart=[[APP_BIN]]' + LineEnding +
    '' + LineEnding +
    '[Install]' + LineEnding +
    'WantedBy=multi-user.target' + LineEnding;
