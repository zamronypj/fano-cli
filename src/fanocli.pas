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
    app := TFanoCliApplication.create(
        nil,
        TInfoTask.create(),
        TCreateProjectTask.create()
    );
    try
        app.run();
    finally
        app.free();
    end;
end.
