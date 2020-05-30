(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheVirtualHostCgiTaskImpl;

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
     * for CGI web application
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheVirtualHostCgiTask = class(TBaseApacheVirtualHostTask)
    protected
        function getVhostTemplate() : string; override;
    end;

implementation

uses

    SysUtils;

    function TApacheVirtualHostCgiTask.getVhostTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/Core/WebServer/Apache/Includes/cgi.vhost.conf.inc}
    begin
        result := strCgiVhostConf;
    end;

end.
