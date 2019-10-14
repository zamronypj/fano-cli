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

    SysUtils;

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
        {$INCLUDE src/Tasks/Implementations/Deploy/WebServer/Apache/Includes/balancer.vhost.conf.inc}
    begin
        result := strBalancerVhostConf;
    end;

    function TApacheVirtualHostBalancerTask.getBalancerMember(const opt : ITaskOptions) : string;
    var i, totalMember, aport : integer;
        host, port : string;
    begin
        host := getHost(opt);
        port := getPort(opt);
        aport := strToInt(port);
        if (not tryStrToInt(opt.getOptionValueDef('total-member', '2'), totalMember)) or
            (totalMember <= 0) then
        begin
            totalMember := 2;
        end;

        result := '';
        for i := 0 to totalMember - 1 do
        begin
            result := result +
                format(
                    'BalancerMember %s://%s:%d' + LineEnding,
                    [fProtocol, host, aport]
                );
            inc(aport);
        end;
    end;

    function TApacheVirtualHostBalancerTask.getBalancerMethod(const opt : ITaskOptions) : string;
    var balancerMethod : string;
    begin
        balancerMethod := opt.getOptionValue('lbmethod');
        if not ((balancerMethod = 'byrequests') or
            (balancerMethod = 'bybusiness') or
            (balancerMethod = 'bytraffic') or
            (balancerMethod = 'byheartbeat')) then
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
