(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateUwsgiAppBootstrapTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateAppBootstrapTaskImpl;

type

    (*!--------------------------------------
     * Task that create uwsgi web application project
     * application bootstrapper using Fano Framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateUwsgiAppBootstrapTask = class(TCreateAppBootstrapTask)
    private
        function getHost(const opt : ITaskOptions) : string;
        function getPort(const opt : ITaskOptions) : string;
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

    function TCreateUwsgiAppBootstrapTask.getHost(const opt : ITaskOptions) : string;
    begin
        //TODO: refactor as this is exactly same as getHost() in TBaseApacheVirtualHostTask
        result := opt.getOptionValue('host');
        if result = '' then
        begin
            result := '127.0.0.1';
        end;
    end;

    function TCreateUwsgiAppBootstrapTask.getPort(const opt : ITaskOptions) : string;
    begin
        //TODO: refactor as this is exactly same as getHost() in TBaseApacheVirtualHostTask
        result := opt.getOptionValue('port');
        if result = '' then
        begin
            result := '20477';
        end;
    end;

    procedure TCreateUwsgiAppBootstrapTask.createApp(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Uwsgi/Includes/app.pas.inc}
    begin
        fContentModifier.setVar('[[HOST]]', getHost(opt));
        fContentModifier.setVar('[[PORT]]', getPort(opt));
        createTextFile(dir + '/app.pas', fContentModifier.modify(strAppPas));
    end;

    procedure TCreateUwsgiAppBootstrapTask.createBootstrap(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Uwsgi/Includes/bootstrap.pas.inc}
    begin
        createTextFile(dir + '/bootstrap.pas', strBootstrapPas);
    end;

end.
