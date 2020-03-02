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
    TCreateAppBootstrapFcgidTaskFactory.create(),
    'public'
);
try
    appInst.registerTask(
        'project-fcgid',
        '--project-fcgid=[project-name] Create new FastCGI project with Apache and mod_fcgid.' + LineEnding +
        '     --config=[ini, json] if omitted, config is not setup.' + LineEnding +
        '     --with-session=[file, cookie, db] Add session support' + LineEnding +
        '     --no-git if omitted, git repository is created.' + LineEnding +
        '     --no-initial-commit if omitted, git repository is created with initial commit.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
