(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheReloadWebServerTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ReloadWebServerTaskImpl;

type

    (*!--------------------------------------
     * Task that reload Apache web server
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheReloadWebServerTask = class(TReloadWebServerTask)
    protected
        function getSvcName() : string; override;
    end;

implementation

uses

    SysUtils;

    function TApacheReloadWebServerTask.getSvcName() : string;
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
end.
