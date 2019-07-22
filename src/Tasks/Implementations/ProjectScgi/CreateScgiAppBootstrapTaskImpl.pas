(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateScgiAppBootstrapTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateAppBootstrapTaskImpl;

type

    (*!--------------------------------------
     * Task that create SCGI web application project
     * application bootstrapper using Fano Framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateScgiAppBootstrapTask = class(TCreateAppBootstrapTask)
    protected
        procedure createApp(const dir : string); override;
        procedure createBootstrap(const dir : string); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateScgiAppBootstrapTask.createApp(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/ProjectScgi/Includes/app.pas.inc}
    begin
        createTextFile(dir + '/app.pas', strAppPas);
    end;

    procedure TCreateScgiAppBootstrapTask.createBootstrap(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/ProjectScgi/Includes/bootstrap.pas.inc}
    begin
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

end.
