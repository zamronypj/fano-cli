(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDaemonAppBootstrapTaskImpl;

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
     * application bootstrapper using Fano Framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDaemonAppBootstrapTask = class(TCreateAppBootstrapTask)
    protected
        procedure createBootstrap(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); override;
    end;

implementation

uses

    sysutils;

    procedure TCreateDaemonAppBootstrapTask.createBootstrap(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Daemon/Includes/bootstrap.pas.inc}
    begin
        fContentModifier.setVar('[[BUILD_DISPATCHER_METHOD_DECL_SECTION]]', '');
        fContentModifier.setVar('[[BUILD_DISPATCHER_METHOD_IMPL_SECTION]]', '');
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

end.
