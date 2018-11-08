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
    fanoapp,
    TaskIntf,
    TaskFactoryIntf,
    InfoTaskImpl,
    NullTaskImpl,
    CreateProjectTaskFactoryImpl;

var
    app : TFanoCliApplication;
    createProjectFactory : ITaskFactory;

begin
    app := TFanoCliApplication.create(nil);
    try
        app.registerTask(
            'help',
            '--help',
            'Display help information',
            TInfoTask.create(app.getTaskList())
        );
        createProjectFactory := TCreateProjectTaskFactory.create();
        app.registerTask(
            'create-project',
            '--create-project=[project name]',
            'Create project task',
            createProjectFactory.build()
        );
        app.run();
    finally
        app.free();
    end;
end.
