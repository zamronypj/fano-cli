(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit XDeployScgiTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for deploy SCGI application
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TXDeployScgiTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        function buildApacheScgiVhostTask() : ITask;
        function buildNginxScgiVhostTask() : ITask;
    public
        function build() : ITask;
    end;

implementation

uses

    FileContentWriterIntf,
    FileContentReaderIntf,
    NullTaskImpl,
    DeployTaskImpl,
    ApacheEnableVhostTaskImpl,
    ApacheReloadWebServerTaskImpl,
    ApacheVirtualHostScgiTaskImpl,
    NginxReloadWebServerTaskImpl,
    NginxVirtualHostScgiTaskImpl,
    AddDomainToEtcHostTaskImpl,
    RootCheckTaskImpl,
    InFanoProjectDirCheckTaskImpl,
    WebServerTaskImpl,
    TextFileCreatorIntf,
    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    ContentModifierImpl,
    FileHelperImpl,
    VirtualHostWriterIntf,
    WebServerVirtualHostTaskImpl,
    VirtualHostImpl,
    VirtualHostWriterImpl,
    ApacheDebianVHostWriterImpl,
    ApacheFedoraVHostWriterImpl,
    ApacheFreeBsdVHostWriterImpl,
    ApacheVHostScgiTplImpl,
    NginxLinuxVHostWriterImpl,
    NginxFreeBsdVHostWriterImpl,
    NginxVHostScgiTplImpl;

    function TXDeployScgiTaskFactory.buildApacheScgiVhostTask() : ITask;
    var vhostWriter : IVirtualHostWriter;
        ftext : ITextFileCreator;
    begin
        ftext := TTextFileCreator.create();
        vhostWriter := (TVirtualHostWriter.create())
            .addWriter('/etc/apache2', TApacheDebianVHostWriter.create(ftext))
            .addWriter('/etc/httpd', TApacheFedoraVHostWriter.create(ftext))
            .addWriter('/usr/local/etc/apache24', TApacheFreeBsdVHostWriter.create(ftext, 'apache24'))
            .addWriter('/usr/local/etc/apache25', TApacheFreeBsdVHostWriter.create(ftext, 'apache25'));

        result := TWebServerVirtualHostTask.create(
            TVirtualHost.create(),
            TApacheVHostScgiTpl.create(),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployScgiTaskFactory.buildNginxScgiVhostTask() : ITask;
    var vhostWriter : IVirtualHostWriter;
        ftext : ITextFileCreator;
    begin
        ftext := TTextFileCreator.create();
        vhostWriter := (TVirtualHostWriter.create())
            .addWriter('/etc/nginx', TNginxLinuxVHostWriter.create(ftext))
            .addWriter('/usr/local/etc/nginx', TNginxFreeBsdVHostWriter.create(ftext));

        result := TWebServerVirtualHostTask.create(
            TVirtualHost.create(),
            TNginxVHostScgiTpl.create(),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployScgiTaskFactory.build() : ITask;
    var deployTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        deployTask := TDeployTask.create(
            TWebServerTask.create(
                buildApacheScgiVhostTask(),
                buildNginxScgiVhostTask()
            ),
            TWebServerTask.create(
                TApacheEnableVhostTask.create(),
                //do nothing. In Nginx we create config in virtual host directory
                //so it automatically enabled
                TNullTask.create()
            ),
            TAddDomainToEtcHostTask.create(fReader, fWriter),
            TWebServerTask.create(
                TApacheReloadWebServerTask.create(),
                TNginxReloadWebServerTask.create()
            )
        );

        //protect to avoid accidentally running without root privilege
        //and not in FanoCLI generated project directory
        result := TRootCheckTask.create(TInFanoProjectDirCheckTask.create(deployTask));
    end;

end.
