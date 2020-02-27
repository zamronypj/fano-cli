(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TDeployHttpBalancerTaskFactory.create();
try
    appInst.registerTask(
        'deploy-lb-http',
        '--deploy-lb-http=[server name] Deploy as http web application with mod_proxy_balancer.' + LineEnding +
        '     --members=[host1:port1,host2:port2,...], if omited, 2 default members is assumed.' + LineEnding +
        '     --lbmethod=[load balancing scheduler algorithm] if omited, byrequests is assumed.' + LineEnding +
        '     --web-server=[web server] if omited, apache is assumed.' + LineEnding +
        '     --doc-root=[document-root] if omited, public directory in current directory is used.' + LineEnding +
        '     --server-ip=[web server ip] if omited, 127.0.0.1 is assumed.' + LineEnding +
        '     --host=[host where http app listen] if omited, 127.0.0.1 is assumed.' + LineEnding +
        '     --port=[port where http app listen] if omited, 20477 is assumed.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
