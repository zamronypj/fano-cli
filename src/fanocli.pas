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
    AppIntf,
    TaskIntf,
    TaskFactoryIntf,
    TaskListAwareIntf,
    FanoAppImpl,
    InfoTaskImpl,
    NullTaskImpl,
    CreateProjectTaskFactoryImpl;

function registerTask(const appInst : IFanoCliApplication; const taskList : ITaskListAware) : IFanoCliApplication;
var
    createProjectFactory : ITaskFactory;
begin
    appInst.registerTask(
        'help',
        '--help',
        'Display help information',
        TInfoTask.create(taskList.getTaskList())
    );

    createProjectFactory := TCreateProjectTaskFactory.create();
    appInst.registerTask(
        'create-project',
        '--create-project=[project name]',
        'Create project task',
        createProjectFactory.build()
    );
    result := appInst;
end;

var
    app : IFanoCliApplication;

begin
    app := TFanoCliApplication.create(nil);
    try
        registerTask(app, app as ITaskListAware);
        app.run();
    finally
        app := nil;
    end;
end.
