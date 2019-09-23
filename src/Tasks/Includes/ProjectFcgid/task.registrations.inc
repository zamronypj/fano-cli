(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TCreateProjectFcgidTaskFactory.create();
try
    appInst.registerTask(
        'project-fcgid',
        '--project-fcgid=[project-name] Create new FastCGI project with Apache and mod_fcgid.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
