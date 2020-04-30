(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateDaemonBootstrapFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateBootstrapFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create bootstrap.pas for daemon
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateDaemonBootstrapFileTask = class(TCreateBootstrapFileTask)
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

    procedure TCreateDaemonBootstrapFileTask.createBootstrap(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Daemon/Includes/bootstrap.pas.inc}
    begin
        fContentModifier.setVar('[[METHOD_DECL_SECTION]]', '');
        fContentModifier.setVar('[[METHOD_IMPL_SECTION]]', '');
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

end.
