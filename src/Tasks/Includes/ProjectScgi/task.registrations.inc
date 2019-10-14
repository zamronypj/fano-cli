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
        'project-scgi',
        '--project-scgi=[project-name] Create new SCGI project' + LineEnding +
        '     --host=[host where SCGI app listen] if omited, 127.0.0.1 is assumed.' + LineEnding +
        '     --port=[port where SCGI app listen] if omited, 20477 is assumed.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;