(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ReloadWebServerTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that reload web server
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TReloadWebServerTask = class(TInterfacedObject, ITask)
    private
        function isSystemD() : boolean;
    protected
        function getSvcName() : string; virtual; abstract;
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils,
    strformats,
    process;

    function TReloadWebServerTask.isSystemD() : boolean;
    begin
        //cheap test if we are in OS where systemD is installed
        result := DirectoryExists('/lib/systemd');
    end;

    function TReloadWebServerTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var svcName : string;
        outputString : string;
    begin
        svcName := getSvcName();
        if (svcName <> '') then
        begin
            if isSystemD() then
            begin
                //run systemctl reload [name of service]
                runCommandInDir(
                    getCurrentDir(),
                    'systemctl',
                    ['reload', svcName],
                    outputString,
                    [poStderrToOutPut]
                );
            end else
            begin
                //assume SysVInit
                //run services [name of service] reload
                runCommandInDir(
                    getCurrentDir(),
                    'service',
                    [ svcName, 'reload'],
                    outputString,
                    [poStderrToOutPut]
                );
            end;
            writeln('Reload ', formatColor(svcName, TXT_GREEN), ' service');
        end else
        begin
            writeln('Cannot reload web server. Unsupported platform or web server.');
        end;
        result := self;
    end;
end.
