(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
program fanocli;

{$MODE OBJFPC}
{$H+}

uses

    {$INCLUDE main.units.inc}

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
