(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TCreateProjectTaskFactory.create();
try
    appInst.registerTask(
        'project',
        '--project=[project-name] Create new CGI project.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
