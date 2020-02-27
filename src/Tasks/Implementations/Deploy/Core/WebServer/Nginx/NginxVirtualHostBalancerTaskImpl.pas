(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NginxVirtualHostBalancerTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    DirectoryCreatorIntf,
    BaseCreateFileTaskImpl,
    BaseNginxVirtualHostTaskImpl;

type

    (*!--------------------------------------
     * Task that creates Nginx virtual host file
     * which use load balancer module
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNginxVirtualHostBalancerTask = class(TBaseNginxVirtualHostTask)
    private
        fProtocol : shortstring;
        fProxyPass : shortstring;
        fProxyParams : shortstring;
        fServerPrefix : shortstring;
        function getBalancerMember(const opt : ITaskOptions) : string;
        function getBalancerMethod(const opt : ITaskOptions) : string;
    protected
        function getVhostTemplate() : string; override;
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const dirCreator : IDirectoryCreator;
            const cntModifier : IContentModifier;
            const baseDir : string = BASE_DIRECTORY;
            const protocol : shortstring = 'scgi';
            const proxyPass : shortstring = 'scgi_pass';
            const proxyParams : shortstring = 'scgi_params';
            const serverPrefix : shortstring = 'lb-'
        );
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    SysUtils,
    RegExpr;

    constructor TNginxVirtualHostBalancerTask.create(
        const txtFileCreator : ITextFileCreator;
        const dirCreator : IDirectoryCreator;
        const cntModifier : IContentModifier;
        const baseDir : string = BASE_DIRECTORY;
        const protocol : shortstring = 'scgi';
        const proxyPass : shortstring = 'scgi_pass';
        const proxyParams : shortstring = 'scgi_params';
        const serverPrefix : shortstring = ''
    );
    begin
        inherited create(txtFileCreator, dirCreator, cntModifier, baseDir);
        fProtocol := protocol;
        fProxyPass := proxyPass;
        fProxyParams := proxyParams;
        fServerPrefix := serverPrefix;
    end;

    function TNginxVirtualHostBalancerTask.getVhostTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/Core/WebServer/Nginx/Includes/balancer.vhost.conf.inc}
    begin
        result := strBalancerVhostConf;
    end;

    function TNginxVirtualHostBalancerTask.getBalancerMember(const opt : ITaskOptions) : string;
    var aport : integer;
        members, host, port : string;
        regex : TRegExpr;
    begin
        host := getHost(opt);
        port := getPort(opt);
        aport := strToInt(port);
        members := opt.getOptionValueDef('members', format('%s:%d,%s:%d', [host, aport, host, aport + 1]));
        regex := TRegExpr.Create();
        try
            regex.Expression := '([a-zA-Z0-9\.]+):([0-9]{1,5})[,]?';
            regex.ModifierG := true;
            result := regex.replace(
                members,
                'server $1:$2;' + LineEnding,
                true
            );
        finally
            regex.free();
        end;
    end;

    function TNginxVirtualHostBalancerTask.getBalancerMethod(const opt : ITaskOptions) : string;
    var balancerMethod : string;
    begin
        balancerMethod := opt.getOptionValue('lbmethod');
        if not ((balancerMethod = 'ip_hash') or
            (balancerMethod = 'least_conn') or
            (balancerMethod = 'random')) then
        begin
            result := '';
        end else
        begin
            result := balancerMethod + ';';
        end;
    end;

    function TNginxVirtualHostBalancerTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        contentModifier.setVar('[[LOAD_BALANCER_MEMBERS]]', getBalancerMember(opt));
        contentModifier.setVar('[[LOAD_BALANCER_METHOD]]', getBalancerMethod(opt));
        contentModifier.setVar('[[PROXY_PASS_TYPE]]', fProxyPass);
        contentModifier.setVar('[[PROXY_PARAMS_TYPE]]', fProxyParams);
        contentModifier.setVar('[[SERVER_PREFIX]]', fServerPrefix);
        inherited run(opt, longOpt);
        result := self;
    end;

end.
