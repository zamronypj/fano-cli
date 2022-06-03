(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WebServerTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that execute task based on what
     * web server is referred
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TWebServerTask = class(TInterfacedObject, ITask)
    private
        fApacheTask : ITask;
        fNginxTask : ITask;
    public
        constructor create(const aApacheTask : ITask; const aNginxTask : ITask);
        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils;

    constructor TWebServerTask.create(const aApacheTask : ITask; const aNginxTask : ITask);
    begin
        fApacheTask := aApacheTask;
        fNginxTask := aNginxTask;
    end;

    destructor TWebServerTask.destroy();
    begin
        fApacheTask := nil;
        fNginxTask := nil;
        inherited destroy();
    end;

    function TWebServerTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var webServer : string;
    begin
        webServer := opt.getOptionValue('web-server');
        if (webServer = 'nginx') then
        begin
            fNginxTask.run(opt, longOpt);
        end else
        begin
            fApacheTask.run(opt, longOpt);
        end;
        result := self;
    end;
end.
