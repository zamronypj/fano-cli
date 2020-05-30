(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NginxVirtualHostHttpTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseNginxVirtualHostTaskImpl;

type

    (*!--------------------------------------
     * Task that creates Nginx virtual host file
     * for http application using reverse proxy
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNginxVirtualHostHttpTask = class(TBaseNginxVirtualHostTask)
    protected
        function getVhostTemplate() : string; override;
    end;

implementation

uses

    SysUtils;

    function TNginxVirtualHostHttpTask.getVhostTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/Core/WebServer/Nginx/Includes/http.vhost.conf.inc}
    begin
        result := strHttpVhostConf;
    end;

end.
