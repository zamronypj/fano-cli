(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NginxVirtualHostFcgiTaskImpl;

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
     * for FastCGI application
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNginxVirtualHostFcgiTask = class(TBaseNginxVirtualHostTask)
    protected
        function getVhostTemplate() : string; override;
    end;

implementation

uses

    SysUtils;

    function TNginxVirtualHostFcgiTask.getVhostTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/WebServer/Nginx/Includes/fcgi.vhost.conf.inc}
    begin
        result := strFcgiVhostConf;
    end;

end.
