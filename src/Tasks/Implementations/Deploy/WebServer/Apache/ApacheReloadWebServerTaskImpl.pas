(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheReloadWebServerTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that adds domain name entry to /etc/hosts
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheReloadWebServerTask = class(TInterfacedObject, ITask)
    private
        function getApacheSvcName() : string;
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils,
    process;

    function TApacheReloadWebServerTask.getApacheSvcName() : string;
    begin
        if directoryExists('/etc/apache2') then
        begin
            //debian-based
            result := 'apache2';
        end else
        if directoryExists('/etc/httpd') then
        begin
            result := 'httpd';
        end else
        begin
            //unsupported
            result := '';
        end;
    end;

    function TApacheReloadWebServerTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var svcName : string;
        outputString : string;
    begin
        svcName := getApacheSvcName();
        if (svcName <> '') then
        begin
            //run systemctl reload apache2 or systemctl reload httpd
            runCommandInDir(
                getCurrentDir(),
                'systemctl',
                ['reload', svcName],
                outputString,
                [poStderrToOutPut]
            );
            writeln(outputString);
        end else
        begin
            writeln('Cannot reload web server. Unsupported platform or web server.');
        end;
        result := self;
    end;
end.
