(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
program fanocli;

{$MODE OBJFPC}
{$H+}

uses
    TaskIntf,
    TaskFactoryIntf,
    TaskListAwareIntf,
    FanoAppImpl,
    InfoTaskImpl,
    CreateProjectTaskFactoryImpl,
    CreateProjectNoGitTaskFactoryImpl;

procedure registerTask(const appInst : TFanoCliApplication);
var
    taskFactory : ITaskFactory;
begin
    appInst.registerTask(
        'help',
        '--help',
        'Display help information',
        TInfoTask.create(appInst.getTaskList())
    );

    taskFactory := TCreateProjectTaskFactory.create();
    try
        appInst.registerTask(
            'create-project',
            '--create-project=[project-name]',
            'Create new project',
            taskFactory.build()
        );
    finally
        taskFactory := nil;
    end;

    taskFactory := TCreateProjectNoGitTaskFactory.create();
    try
        appInst.registerTask(
            'create-project-without-git',
            '--create-project-without-git=[project-name]',
            'Create project without Git repository',
            taskFactory.build()
        );
    finally
        taskFactory := nil;
    end;

end;

var
    app : TFanoCliApplication;

begin
    app := TFanoCliApplication.create(nil);
    try
        registerTask(app);
        app.run();
    finally
        app.free();
    end;
end.
