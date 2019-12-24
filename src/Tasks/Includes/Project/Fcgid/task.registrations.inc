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
    TCreateAppBootstrapFcgidTaskFactory.create()
);
try
    appInst.registerTask(
        'project-fcgid',
        '--project-fcgid=[project-name] Create new FastCGI project with Apache and mod_fcgid.' + LineEnding +
        '     --config=[ini, json] if omited, config is not setup.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
