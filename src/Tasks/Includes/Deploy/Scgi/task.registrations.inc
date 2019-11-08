(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TDeployScgiTaskFactory.create();
try
    appInst.registerTask(
        'deploy-scgi',
        '--deploy-scgi=[server name] Deploy as SCGI web application.' + LineEnding +
        '     --web-server=[web server] if omited, apache is assumed.' + LineEnding +
        '     --doc-root=[document-root] if omited, public directory in current directory is used.' + LineEnding +
        '     --server-ip=[web server ip] if omited, 127.0.0.1 is assumed.' + LineEnding +
        '     --host=[host where SCGI app listen] if omited, 127.0.0.1 is assumed.' + LineEnding +
        '     --port=[port where SCGI app listen] if omited, 20477 is assumed.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
