(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TCreateProjectNoGitTaskFactory.create();
try
    appInst.registerTask(
        'create-project-without-git',
        '--create-project-without-git=[project-name] ' +
        'Create project without Git repository',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
