(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TCreateControllerTaskFactory.create();
try
    appInst.registerTask(
        'controller',
        '--controller=[controller-name] Create new controller',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
