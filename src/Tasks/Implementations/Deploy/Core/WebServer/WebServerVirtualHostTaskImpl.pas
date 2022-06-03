(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit WebServerVirtualHostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    ContentModifierIntf,
    VirtualHostIntf,
    VirtualHostTemplateIntf,
    VirtualHostWriterIntf;

type

    (*!--------------------------------------
     * Task that creates web server virtual host file
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TWebServerVirtualHostTask = class(TInterfacedObject, ITask)
    private
        fVhost : IVirtualHost;
        fVhostTpl : IVirtualHostTemplate;
        fVhostWriter : IVirtualHostWriter;
        fContentModifier : IContentModifier;
    public
        constructor create(
            const aVhost : IVirtualHost;
            const aVhostTpl : IVirtualHostTemplate;
            const aVhostWriter : IVirtualHostWriter;
            const aContentModifier : IContentModifier
        );

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

    constructor TWebServerVirtualHostTask.create(
        const aVhost : IVirtualHost;
        const aVhostTpl : IVirtualHostTemplate;
        const aVhostWriter : IVirtualHostWriter;
        const aContentModifier : IContentModifier
    );
    begin
        fVhost := aVhost;
        fVhostTpl := aVhostTpl;
        fVhostWriter := aVhostWriter;
        fContentModifier := aContentModifier;
    end;

    function TWebServerVirtualHostTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var serverName : string;
    begin
        serverName := fVhost.getServerName(opt, longOpt);
        fContentModifier.setVar('[[SERVER_NAME]]', serverName);
        fContentModifier.setVar('[[DOC_ROOT]]', fVhost.getDocumentRoot(opt, longOpt));
        fContentModifier.setVar('[[HOST]]', fVhost.getHost(opt, longOpt));
        fContentModifier.setVar('[[PORT]]', fVhost.getPort(opt, longOpt));
        fVhostWriter.writeVhost(
            serverName,
            fVhostTpl.getVhostTemplate(opt, longOpt, fContentModifier),
            fContentModifier
        );
        result := self;
    end;
end.
