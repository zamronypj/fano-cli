(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheVHostBalancerTplImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    ContentModifierIntf,
    VirtualHostIntf,
    VirtualHostTemplateIntf;

type

    (*!--------------------------------------
     * Task that creates apache virtual host template
     * for load balancer web application with mod_proxy
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheVHostBalancerTpl = class(TInterfacedObject, IVirtualHostTemplate)
    private
        fVhost : IVirtualHost;
        fProtocol : shortstring;
        function getBalancerMember(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : string;
        function getBalancerMethod(const opt : ITaskOptions) : string;
    public
        constructor create(
            const aVhost : IVirtualHost;
            const protocol : shortstring = 'scgi'
        );

        function getVhostTemplate(
            const opt : ITaskOptions;
            const longOpt : shortstring;
            const cntModifier : IContentModifier
        ) : string;
    end;

implementation

uses

    SysUtils,
    RegExpr;

    constructor TApacheVHostBalancerTpl.create(
        const aVhost : IVirtualHost;
        const protocol : shortstring = 'scgi'
    );
    begin
        fVhost := aVhost;
        fProtocol := protocol;
    end;

    function TApacheVHostBalancerTpl.getBalancerMember(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : string;
    var aport : integer;
        members, host, port : string;
        regex : TRegExpr;
    begin
        host := fVhost.getHost(opt, longOpt);
        port := fVhost.getPort(opt, longOpt);
        aport := strToInt(port);
        members := opt.getOptionValueDef('members', format('%s:%d,%s:%d', [host, aport, host, aport + 1]));
        regex := TRegExpr.Create();
        try
            regex.Expression := '([a-zA-Z0-9\.]+):([0-9]{1,5})[,]?';
            regex.ModifierG := true;
            result := regex.replace(
                members,
                format('BalancerMember %s://$1:$2' + LineEnding, [fProtocol]),
                true
            );
        finally
            regex.free();
        end;
    end;

    function TApacheVHostBalancerTpl.getBalancerMethod(const opt : ITaskOptions) : string;
    var balancerMethod : string;
    begin
        balancerMethod := opt.getOptionValue('lbmethod');
        if not ((balancerMethod = 'byrequests') or
            (balancerMethod = 'bybusyness') or
            (balancerMethod = 'bytraffic') or
            (balancerMethod = 'heartbeat')) then
        begin
            balancerMethod := 'byrequests';
        end;
        result := balancerMethod;
    end;

    function TApacheVHostBalancerTpl.getVhostTemplate(
        const opt : ITaskOptions;
        const longOpt : shortstring;
        const cntModifier : IContentModifier
    ) : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/Core/WebServer/Apache/Includes/balancer.vhost.conf.inc}
    begin
        cntModifier.setVar('[[LOAD_BALANCER_MEMBERS]]', getBalancerMember(opt, longOpt));
        cntModifier.setVar('[[LOAD_BALANCER_METHOD]]', getBalancerMethod(opt));
        result := cntModifier.modify(strBalancerVhostConf);
    end;

end.
