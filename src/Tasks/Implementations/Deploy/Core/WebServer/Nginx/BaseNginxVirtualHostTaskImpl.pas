(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseNginxVirtualHostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    TextFileCreatorIntf,
    ContentModifierIntf,
    DirectoryCreatorIntf,
    FileContentReaderIntf,
    FileContentWriterIntf,
    CreateFileConsts,
    BaseWebServerVirtualHostTaskImpl;

type

    (*!--------------------------------------
     * Task that creates nginx virtual host file
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseNginxVirtualHostTask = class(TBaseWebServerVirtualHostTask)
    private
        fContentReader : IFileContentReader;
        fContentWriter : IFileContentWriter;
        procedure doAddVHostIncludeIfNotExists(
            const nginxConfigDir : string
        );
        procedure doCreateVhostFile(
            const opt : ITaskOptions;
            const serverName : string;
            const nginxConfigDir : string
        );
    protected
        procedure createVhostFile(
            const opt : ITaskOptions;
            const serverName : string
        ); override;
    public
        constructor create(
            const txtFileCreator : ITextFileCreator;
            const dirCreator : IDirectoryCreator;
            const cntModifier : IContentModifier;
            const cntReader : IFileContentReader;
            const cntWriter : IFileContentWriter;
            const baseDir : string = BASE_DIRECTORY
        );
        destructor destroy(); override;
    end;

implementation

uses

    SysUtils,
    strutils,
    regexpr,
    strformats;

    function execRegex(const regex : string; const inputStr : string) : boolean;
    var reg : TRegExpr;
    begin
        reg:= TRegExpr.create();
        try
            reg.ModifierM := true;
            reg.Expression := regex;
            result := reg.Exec(inputStr) ;
        finally
            reg.free();
        end;
    end;

    function isVHostIncludeExists(
        const nginxConfigDir : string;
        const nginxConfContent : string
    ) : boolean;
    begin
        result := (pos('include ' + nginxConfigDir + '/conf.d/*', nginxConfContent) > 0) and
            (not execRegex(
                '\s*#[ \t]*include\s+' + QuoteRegExprMetaChars(nginxConfigDir + '/conf.d/*'),
                nginxConfContent
            ));
    end;

    function addVHostIncludeIfNotExists(
        const nginxConfigDir : string;
        nginxConfContent : string
    ) : string;
    var lastCurlyBracket : integer;
    begin
        if not isVHostIncludeExists(nginxConfigDir, nginxConfContent) then
        begin
            lastCurlyBracket := rpos('}', nginxConfContent);
            insert(
                LineEnding + '   include ' + nginxConfigDir + '/conf.d/*' + LineEnding,
                nginxConfContent,
                lastCurlyBracket
            );
            result := nginxConfContent;
        end else
        begin
            result := nginxConfContent;
        end;
    end;

    constructor TBaseNginxVirtualHostTask.create(
        const txtFileCreator : ITextFileCreator;
        const dirCreator : IDirectoryCreator;
        const cntModifier : IContentModifier;
        const cntReader : IFileContentReader;
        const cntWriter : IFileContentWriter;
        const baseDir : string = BASE_DIRECTORY
    );
    begin
        inherited create(txtFileCreator, dirCreator, cntModifier, baseDir);
        fContentReader := cntReader;
        fContentWriter := cntWriter;
    end;

    destructor TBaseNginxVirtualHostTask.destroy();
    begin
        fContentReader := nil;
        fContentWriter := nil;
        inherited destroy();
    end;

    procedure TBaseNginxVirtualHostTask.doAddVHostIncludeIfNotExists(
        const nginxConfigDir : string
    );
    var nginxConfContent : string;
    begin
        nginxConfContent := fContentReader.read(nginxConfigDir + '/nginx.conf');
        nginxConfContent := addVHostIncludeIfNotExists(nginxConfigDir, nginxConfContent);
        fContentWriter.write(nginxConfigDir + '/nginx.conf', nginxConfContent);
    end;

    procedure TBaseNginxVirtualHostTask.doCreateVhostFile(
        const opt : ITaskOptions;
        const serverName : string;
        const nginxConfigDir : string
    );
    begin
        contentModifier.setVar('[[NGINX_LOG_DIR]]', '/var/log/nginx');
        createDirIfNotExists(nginxConfigDir + '/conf.d');
        doAddVHostIncludeIfNotExists(nginxConfigDir);
        createTextFile(
            nginxConfigDir + '/conf.d/' + serverName + '.conf',
            getVhostTemplate()
        );
        writeln(
            'Create virtual host ',
            formatColor(nginxConfigDir + '/conf.d/' + serverName + '.conf', TXT_GREEN)
        );
    end;

    procedure TBaseNginxVirtualHostTask.createVhostFile(
        const opt : ITaskOptions;
        const serverName : string
    );
    begin
        if directoryExists('/etc/nginx') then
        begin
            //in Linux
            doCreateVhostFile(opt, serverName, '/etc/nginx');
        end else
        if directoryExists('/usr/local/etc/nginx') then
        begin
            doCreateVhostFile(opt, serverName, '/usr/local/etc/nginx');
        end else
        begin
            writeln('Unsupported platform or web server');
        end;
    end;

end.
