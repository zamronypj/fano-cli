(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TDeployFCgidTaskFactory.create();
try
    appInst.registerTask(
        'deploy-fcgid',
        '--deploy-fcgid=[server name] Deploy as FastCGI web application with mod_fcgid.' + LineEnding +
        '    --web-server=[web server] if omited, apache is assumed.' + LineEnding +
        '    --doc-root=[document-root] if omited, public directory in current directory is used.' + LineEnding +
        '    --server-ip=[web server ip] if omited, 127.0.0.1 is assumed.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
