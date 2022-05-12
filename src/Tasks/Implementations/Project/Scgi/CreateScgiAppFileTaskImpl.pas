(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateScgiAppFileTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateAppFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create SCGI web application project
     * application app.pas
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateScgiAppFileTask = class(TCreateAppFileTask)
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

    function TCreateScgiAppFileTask.getHost(const opt : ITaskOptions) : string;
    begin
        //TODO: refactor as this is exactly same as getHost() in TBaseApacheVirtualHostTask
        result := opt.getOptionValue('host');
        if result = '' then
        begin
            result := '127.0.0.1';
        end;
    end;

    function TCreateScgiAppFileTask.getPort(const opt : ITaskOptions) : string;
    begin
        //TODO: refactor as this is exactly same as getHost() in TBaseApacheVirtualHostTask
        result := opt.getOptionValue('port');
        if result = '' then
        begin
            result := '20477';
        end;
    end;

    procedure TCreateScgiAppFileTask.createApp(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const dir : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Project/Scgi/Includes/app.pas.inc}
    begin
        fContentModifier.setVar('[[HOST]]', getHost(opt));
        fContentModifier.setVar('[[PORT]]', getPort(opt));
        createTextFile(dir + '/app.pas', fContentModifier.modify(strAppPas));
    end;

end.
