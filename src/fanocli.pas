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
    InfoTaskImpl,
    NullTaskImpl,
    CreateProjectTaskImpl;

var
    app : TFanoCliApplication;

begin
    app := TFanoCliApplication.create(nil);
    try
        app.registerTask(
            'h',
            'help',
            '-h',
            '--help',
            'Display help information',
            TInfoTask.create(app.getTaskList())
        );
        app.registerTask(
            'c',
            'create-project',
            '-c [project name]',
            '--create-project=[project name]',
            'Create project task',
            TCreateProjectTask.create()
        );
        app.run();
    finally
        app.free();
    end;
end.
