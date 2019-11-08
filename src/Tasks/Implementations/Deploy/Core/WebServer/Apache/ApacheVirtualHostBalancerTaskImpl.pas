(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheVirtualHostBalancerTaskImpl;

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
    BaseApacheVirtualHostTaskImpl;

type

    (*!--------------------------------------
     * Task that creates apache virtual host file
     * with mod_proxy_balancer module
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheVirtualHostBalancerTask = class(TBaseApacheVirtualHostTask)
    private
        fProtocol : shortstring;
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
            const protocol : shortstring = 'scgi'
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

    constructor TApacheVirtualHostBalancerTask.create(
        const txtFileCreator : ITextFileCreator;
        const dirCreator : IDirectoryCreator;
        const cntModifier : IContentModifier;
        const baseDir : string = BASE_DIRECTORY;
        const protocol : shortstring = 'scgi'
    );
    begin
        inherited create(txtFileCreator, dirCreator, cntModifier, baseDir);
        fProtocol := protocol;
    end;

    function TApacheVirtualHostBalancerTask.getVhostTemplate() : string;
    var
        {$INCLUDE src/Tasks/Implementations/Deploy/Core/WebServer/Apache/Includes/balancer.vhost.conf.inc}
    begin
        result := strBalancerVhostConf;
    end;

    function TApacheVirtualHostBalancerTask.getBalancerMember(const opt : ITaskOptions) : string;
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
                format('BalancerMember %s://$1:$2' + LineEnding, [fProtocol]),
                true
            );
        finally
            regex.free();
        end;
    end;

    function TApacheVirtualHostBalancerTask.getBalancerMethod(const opt : ITaskOptions) : string;
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

    function TApacheVirtualHostBalancerTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        contentModifier.setVar('[[LOAD_BALANCER_MEMBERS]]', getBalancerMember(opt));
        contentModifier.setVar('[[LOAD_BALANCER_METHOD]]', getBalancerMethod(opt));
        inherited run(opt, longOpt);
        result := self;
    end;

end.
