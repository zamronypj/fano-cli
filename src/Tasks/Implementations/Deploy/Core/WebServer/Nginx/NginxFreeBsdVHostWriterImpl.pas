(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit NginxFreeBsdVHostWriterImpl;

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
     * Task that creates nginx web server virtual host file
     * in FreeBsd
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TNginxFreeBsdVHostWriter = class(TInterfacedObject, IVirtualHostWriter)
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

    constructor TNginxFreeBsdVHostWriter.create(
        const txtFileCreator : ITextFileCreator
    );
    begin
        fTextFileCreator := txtFileCreator;
    end;

    procedure TNginxFreeBsdVHostWriter.writeVhost(
        const serverName : string;
        const vhostTpl : string;
        const cntModifier : IContentModifier);
    begin
        cntModifier.setVar('[[NGINX_LOG_DIR]]', '/var/log/nginx');
        fTextFileCreator.createTextFile(
            '/usr/local/etc/nginx/conf.d/' + serverName + '.conf',
            cntModifier.modify(vhostTpl)
        );
    end;

end.
