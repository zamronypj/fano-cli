(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheOpenBsdVHostWriterImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    FileContentAppenderIntf,
    ContentModifierIntf,
    VirtualHostWriterIntf;

type

    (*!--------------------------------------
     * Task that creates Apache web server virtual host file
     * in OpenBSD
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheOpenBsdVHostWriter = class(TInterfacedObject, IVirtualHostWriter)
    private
        fTextFileAppender : IFileContentAppender;
        fApacheVer : string;
    public
        constructor create(
            const txtFileAppender : IFileContentAppender;
            const apacheVer : string = 'apache2'
        );
        procedure writeVhost(
            const serverName : string;
            const vhostTpl : string;
            const cntModifier : IContentModifier
        );
    end;

implementation

uses

    SysUtils;

    constructor TApacheOpenBsdVHostWriter.create(
        const txtFileAppender : IFileContentAppender;
        const apacheVer : string = 'apache2'
    );
    begin
        fTextFileAppender := txtFileAppender;
        fApacheVer := apacheVer;
    end;

    procedure TApacheOpenBsdVHostWriter.writeVhost(
        const serverName : string;
        const vhostTpl : string;
        const cntModifier : IContentModifier);
    begin
        cntModifier.setVar('[[APACHE_LOG_DIR]]', '/var/log');
        fTextFileAppender.createTextFile(
            '/etc/' + fApacheVer + '/extra/httpd-vhosts.conf',
            cntModifier.modify(vhostTpl)
        );
    end;

end.
