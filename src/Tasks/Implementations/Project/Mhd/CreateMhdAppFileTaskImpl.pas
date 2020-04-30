(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateMhdAppFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateAppFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create libmicrohttpd http web
     * application project app.pas
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateMhdAppFileTask = class(TCreateAppFileTask)
    private
        function getHost(const opt : ITaskOptions) : string;
        function getPort(const opt : ITaskOptions) : string;
    protected
        procedure createApp(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const dir : string
        ); override;
    end;

implementation

uses

    sysutils;

    function TCreateMhdAppFileTask.getHost(const opt : ITaskOptions) : string;
    begin
        //TODO: refactor as this is exactly same as getHost() in TBaseApacheVirtualHostTask
        result := opt.getOptionValue('host');
        if result = '' then
        begin
            result := '127.0.0.1';
        end;
    end;

    function TCreateMhdAppFileTask.getPort(const opt : ITaskOptions) : string;
    begin
        //TODO: refactor as this is exactly same as getHost() in TBaseApacheVirtualHostTask
        result := opt.getOptionValue('port');
        if result = '' then
        begin
            result := '20477';
        end;
    end;

    procedure TCreateMhdAppFileTask.createApp(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Mhd/Includes/app.pas.inc}
    begin
        fContentModifier.setVar('[[HOST]]', getHost(opt));
        fContentModifier.setVar('[[PORT]]', getPort(opt));
        createTextFile(dir + '/app.pas', fContentModifier.modify(strAppPas));
    end;

end.
