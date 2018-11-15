(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TCreateProjectNoCommitTaskFactory.create();
try
    appInst.registerTask(
        'create-project-no-commit',
        '--create-project-no-commit=[project-name] ' +
        'Create project with Git repository but without committing them',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
