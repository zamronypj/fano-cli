(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

{%../Includes/task.registrations.inc}

taskFactory := TCreateProjectTaskFactory.create(
    TCreateProjectDependenciesTaskFactory.create(),
    TCreateAppBootstrapTaskFactory.create()
);
try
    appInst.registerTask(
        'project',
        '--project=[project-name] Create new CGI project.' + LineEnding +
        '     --config=[json, ini] Type of generated application config. If omitted, json is assumed.' + LineEnding +
        '     --with-session=[file, cookie, db] Add session support',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
