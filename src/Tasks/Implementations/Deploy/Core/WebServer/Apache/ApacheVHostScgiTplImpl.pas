(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheVHostScgiTplImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    ContentModifierIntf,
    VirtualHostTemplateIntf;

type

    (*!--------------------------------------
     * Task that creates apache virtual host template
     * for SCGI web application with mod_proxy_scgi
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheVHostScgiTpl = class(TInterfacedObject, IVirtualHostTemplate)
    public
        function getVhostTemplate(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const cntModifier : IContentModifier
        ) : string;
    end;

implementation

uses

    SysUtils;

    function TApacheVHostScgiTpl.getVhostTemplate(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const cntModifier : IContentModifier
    ) : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/Core/WebServer/Apache/Includes/scgi.vhost.conf.inc}
    begin
        result := strScgiVhostConf;
    end;

end.
