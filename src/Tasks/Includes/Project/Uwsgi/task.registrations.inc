(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
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
        formatColor('--project-uwsgi', TXT_GREEN) + '=[project-name] Create new uwsgi project' + LineEnding +
        '     --config=[ini, json] if omitted, config is not setup.' + LineEnding +
        '     --host=[host where uwsgi app listen] if omitted, 127.0.0.1 is assumed.' + LineEnding +
        '     --port=[port where uwsgi app listen] if omitted, 20477 is assumed.' + LineEnding +
        '     --with-session=[file, cookie, db] Add session support' + LineEnding +
        '     --with-middleware Add middleware support' + LineEnding +
        '     --with-csrf Add CSRF support' + LineEnding +
        '     --with-logger=[file, db, syslog] Add logger dependencies' + LineEnding +
        '     --no-git if omitted, git repository is created.' + LineEnding +
        '     --no-initial-commit if omitted, git repository is created with initial commit.',
        taskFactory.build()
    );
finally
    taskFactory := nil;
end;
