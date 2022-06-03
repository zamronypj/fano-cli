(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NginxLinuxVHostWriterImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    VirtualHostWriterIntf;

type

    (*!--------------------------------------
     * Task that creates Apache web server virtual host file
     * in Debian-based distros
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNginxLinuxVHostWriter = class(TInterfacedObject, IVirtualHostWriter)
    private
        fTextFileCreator : ITextFileCreator;
    public
        constructor create(const txtFileCreator : ITextFileCreator);
        procedure writeVhost(
            const serverName : string;
            const vhostTpl : string;
            const cntModifier : IContentModifier
        );
    end;

implementation

uses

    SysUtils;

    constructor TNginxLinuxVHostWriter.create(const txtFileCreator : ITextFileCreator);
    begin
        fTextFileCreator := txtFileCreator;
    end;

    procedure TNginxLinuxVHostWriter.writeVhost(
        const serverName : string;
        const vhostTpl : string;
        const cntModifier : IContentModifier);
    begin
        cntModifier.setVar('[[NGINX_LOG_DIR]]', '/var/log/nginx');
        fTextFileCreator.createTextFile(
            '/etc/nginx/conf.d/' + serverName + '.conf',
            cntModifier.modify(vhostTpl)
        );
    end;

end.
