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
        'project-no-commit',
        '--project-no-commit=[project-name] '+
        'Create project with Git repository but without committing them.' + LineEnding +
        '     --config=[ini, json] if omited, config is not setup.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
