(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateFcgidAppBootstrapTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateAppBootstrapTaskImpl;

type

    (*!--------------------------------------
     * Task that create FastCGI web application project
     * with Apache web server and mod_fcgid module
     * application bootstrapper using Fano Framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateFcgidAppBootstrapTask = class(TCreateAppBootstrapTask)
    protected
        procedure createApp(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); override;

        procedure createBootstrap(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateFcgidAppBootstrapTask.createApp(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Fcgid/Includes/app.pas.inc}
    begin
        createTextFile(dir + '/app.pas', strAppPas);
    end;

    procedure TCreateFcgidAppBootstrapTask.createBootstrap(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Fcgid/Includes/bootstrap.pas.inc}
    begin
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

end.
