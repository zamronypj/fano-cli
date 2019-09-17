(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit BaseApacheVirtualHostTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that creates apache virtual host file
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TBaseApacheVirtualHostTask = class(TBaseCreateFileTask)
    private
        function getDocumentRoot(const opt : ITaskOptions) : string;
        function getHost(const opt : ITaskOptions) : string;
        function getPort(const opt : ITaskOptions) : string;
    protected
        function getVhostTemplate() : string; virtual; abstract;
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    SysUtils;

    function TBaseApacheVirtualHostTask.getDocumentRoot(const opt : ITaskOptions) : string;
    begin
        result := opt.getOptionValue('doc-root');
        if result = '' then
        begin
            result := getCurrentDir() + '/public';
        end;
    end;

    function TBaseApacheVirtualHostTask.getHost(const opt : ITaskOptions) : string;
    begin
        result := opt.getOptionValue('host');
        if result = '' then
        begin
            result := '127.0.0.1';
        end;
    end;

    function TBaseApacheVirtualHostTask.getPort(const opt : ITaskOptions) : string;
    begin
        result := opt.getOptionValue('port');
        if result = '' then
        begin
            result := '20477';
        end;
    end;

    function TBaseApacheVirtualHostTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var serverName : string;
    begin
        inherited run(opt, longOpt);
        serverName := opt.getOptionValue(longOpt);
        contentModifier.setVar('[[SERVER_NAME]]', serverName);
        contentModifier.setVar('[[DOC_ROOT]]', getDocumentRoot(opt));
        contentModifier.setVar('[[HOST]]', getHost(opt));
        contentModifier.setVar('[[PORT]]', getPort(opt));

        if directoryExists('/etc/apache2') then
        begin
            //debian-based
            contentModifier.setVar('[[APACHE_LOG_DIR]]', '/var/log/apache2');
            createTextFile(
                '/etc/apache2/sites-available/' + serverName + '.conf',
                getVhostTemplate()
            );
            writeln('Create virtual host /etc/apache2/sites-available/' + serverName + '.conf');
        end else
        if directoryExists('/etc/httpd') then
        begin
            //fedora-based
            contentModifier.setVar('[[APACHE_LOG_DIR]]', '/var/log/httpd');
            createTextFile(
                '/etc/httpd/conf.d/' + serverName + '.conf',
                getVhostTemplate()
            );
            writeln('Create virtual host /etc/httpd/conf.d/' + serverName + '.conf');
        end else
        begin
            writeln('Unsupported platform or web server');
        end;

        result := self;
    end;
end.
