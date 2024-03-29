(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TXDeployScgiBalancerTaskFactory.create();
try
    appInst.registerTask(
        'deploy-lb-scgi',
        formatColor('--deploy-lb-scgi', TXT_GREEN) + '=[server name] Deploy as SCGI web application with mod_proxy_balancer.' + LineEnding +
        '     --members=[host1:port1,host2:port2,...], if omitted, 2 default members is assumed.' + LineEnding +
        '     --lbmethod=[load balancing scheduler algorithm] if omitted, byrequests is assumed.' + LineEnding +
        '     --web-server=[web server] if omitted, apache is assumed.' + LineEnding +
        '     --doc-root=[document-root] if omitted, public directory in current directory is used.' + LineEnding +
        '     --server-ip=[web server ip] if omitted, 127.0.0.1 is assumed.' + LineEnding +
        '     --host=[host where SCGI app listen] if omitted, 127.0.0.1 is assumed.' + LineEnding +
        '     --port=[port where SCGI app listen] if omitted, 20477 is assumed.' + LineEnding +
        '     --stdout=Output virtual host configuration to STDOUT (no root privilege needed).',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
