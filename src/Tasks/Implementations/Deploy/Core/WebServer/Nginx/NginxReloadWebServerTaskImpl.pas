(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NginxReloadWebServerTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ReloadWebServerTaskImpl;

type

    (*!--------------------------------------
     * Task that adds domain name entry to /etc/hosts
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNginxReloadWebServerTask = class(TReloadWebServerTask)
    protected
        function getSvcName() : string; override;
    end;

implementation

    function TNginxReloadWebServerTask.getSvcName() : string;
    begin
        result := 'nginx';
    end;

end.
