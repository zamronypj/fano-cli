(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TCreateDaemonProjectTaskFactory.create(
    TCreateProjectDependenciesTaskFactory.create(),
    TCreateAppBootstrapUwsgiTaskFactory.create()
);
try
    appInst.registerTask(
        'project-uwsgi',
        '--project-scgi=[project-name] Create new uwsgi project' + LineEnding +
        '     --config=[ini, json] if omited, config is not setup.' + LineEnding +
        '     --host=[host where uwsgi app listen] if omited, 127.0.0.1 is assumed.' + LineEnding +
        '     --port=[port where uwsgi app listen] if omited, 20477 is assumed.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
