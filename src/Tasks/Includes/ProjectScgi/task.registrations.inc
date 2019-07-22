(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TCreateProjectScgiTaskFactory.create();
try
    appInst.registerTask(
        'create-project-scgi',
        '--create-project-scgi=[project-name] Create new SCGI project',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
