(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheVirtualHostScgiTaskImpl;

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
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheVirtualHostScgiTask = class(TBaseApacheVirtualHostTask)
    protected
        function getVhostTemplate() : string; override;
    end;

implementation

uses

    SysUtils;

    function TApacheVirtualHostScgiTask.getVhostTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/Core/WebServer/Apache/Includes/scgi.vhost.conf.inc}
    begin
        result := strScgiVhostConf;
    end;

end.
