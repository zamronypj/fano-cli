(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheVirtualHostFcgiTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseApacheVirtualHostTaskImpl;

type

    (*!--------------------------------------
     * Task that creates apache virtual host file
     * for FastCGI application running with mod_proxy_fcgi
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheVirtualHostFcgiTask = class(TBaseApacheVirtualHostTask)
    protected
        function getVhostTemplate() : string; override;
    end;

implementation

uses

    SysUtils;

    function TApacheVirtualHostFcgiTask.getVhostTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/Core/WebServer/Apache/Includes/fcgi.vhost.conf.inc}
    begin
        result := strFcgiVhostConf;
    end;

end.
