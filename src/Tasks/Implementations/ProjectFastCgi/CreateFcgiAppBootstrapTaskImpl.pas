(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFcgiAppBootstrapTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateSimpleAppBootstrapTaskImpl;

type

    (*!--------------------------------------
     * Task that create FastCGI web application project
     * application bootstrapper using Fano Framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFcgiAppBootstrapTask = class(TCreateSimpleAppBootstrapTask)
    protected
        procedure createApp(const dir : string); override;
        procedure createBootstrap(const dir : string); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateFcgiAppBootstrapTask.createApp(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/ProjectFastCgi/Includes/app.pas.inc}
    begin
        createTextFile(dir + '/app.pas', strAppPas);
    end;

    procedure TCreateFcgiAppBootstrapTask.createBootstrap(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/ProjectFastCgi/Includes/bootstrap.pas.inc}
    begin
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

end.
