(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit ApacheWindowsVHostWriterImpl;

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
     * in Windows
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TApacheWindowsVHostWriter = class(TInterfacedObject, IVirtualHostWriter)
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

    constructor TApacheWindowsVHostWriter.create(const txtFileCreator : ITextFileCreator);
    begin
        fTextFileCreator := txtFileCreator;
    end;

    procedure TApacheWindowsVHostWriter.writeVhost(
        const serverName : string;
        const vhostTpl : string;
        const cntModifier : IContentModifier
    );
    begin
        cntModifier.setVar('[[APACHE_LOG_DIR]]', '/var/log/apache2');
        fTextFileCreator.createTextFile(
            '/etc/apache2/sites-available/' + serverName + '.conf',
            cntModifier.modify(vhostTpl)
        );
    end;

end.
