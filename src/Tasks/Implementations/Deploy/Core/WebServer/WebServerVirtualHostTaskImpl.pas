(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WebServerVirtualHostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    VirtualHostIntf,
    VirtualHostTemplateIntf,
    VirtualHostWriterIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that creates web server virtual host file
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseWebServerVirtualHostTask = class(TBaseCreateFileTask)
    private
        fVhost : IVirtualHost;
        fVhostTpl : IVirtualHostTemplate;
        fVhostWriter : IVirtualHostWriter;
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

    function TBaseWebServerVirtualHostTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        inherited run(opt, longOpt);
        contentModifier.setVar('[[SERVER_NAME]]', fVhost.getServerName(opt, longOpt));
        contentModifier.setVar('[[DOC_ROOT]]', fVhost.getDocumentRoot(opt, longOpt));
        contentModifier.setVar('[[HOST]]', fVhost.getHost(opt, longOpt));
        contentModifier.setVar('[[PORT]]', fVhost.getPort(opt, longOpt));
        fVhostWriter.writeVhost(fVhostTpl.getVhostTemplate(), contentModifier);
        result := self;
    end;
end.
