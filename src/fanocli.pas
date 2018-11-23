(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
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
    CreateProjectNoGitTaskFactoryImpl,
    CreateProjectNoCommitTaskFactoryImpl,
    CreateControllerTaskFactoryImpl,
    CreateViewTaskFactoryImpl,
    CreateModelTaskFactoryImpl,
    CreateMvcTaskFactoryImpl;

    procedure registerTask(const appInst : TFanoCliApplication);
    var
        taskFactory : ITaskFactory;
    begin
        {$INCLUDE Tasks/Includes/task.registrations.inc}
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
