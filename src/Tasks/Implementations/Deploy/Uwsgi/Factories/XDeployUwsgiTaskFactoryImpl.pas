(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit XDeployUwsgiTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for deploy uwsgi application
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TXDeployUwsgiTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        function buildApacheUwsgiVhostTask() : ITask;
        function buildNginxUwsgiVhostTask() : ITask;
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
    ApacheVirtualHostUwsgiTaskImpl,
    NginxReloadWebServerTaskImpl,
    NginxVirtualHostUwsgiTaskImpl,
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
    ApacheVHostUwsgiTplImpl,
    NginxLinuxVHostWriterImpl,
    NginxFreeBsdVHostWriterImpl,
    NginxVHostUwsgiTplImpl;

    function TXDeployUwsgiTaskFactory.buildApacheUwsgiVhostTask() : ITask;
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
            TApacheVHostUwsgiTpl.create(),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployUwsgiTaskFactory.buildNginxUwsgiVhostTask() : ITask;
    var vhostWriter : IVirtualHostWriter;
        ftext : ITextFileCreator;
    begin
        ftext := TTextFileCreator.create();
        vhostWriter := (TVirtualHostWriter.create())
            .addWriter('/etc/nginx', TNginxLinuxVHostWriter.create(ftext))
            .addWriter('/usr/local/etc/nginx', TNginxFreeBsdVHostWriter.create(ftext));

        result := TWebServerVirtualHostTask.create(
            TVirtualHost.create(),
            TNginxVHostUwsgiTpl.create(),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployUwsgiTaskFactory.build() : ITask;
    var deployTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        deployTask := TDeployTask.create(
            TWebServerTask.create(
                TApacheVirtualHostUwsgiTask.create(
                    TTextFileCreator.create(),
                    TDirectoryCreator.create(),
                    TContentModifier.create()
                ),
                TNginxVirtualHostUwsgiTask.create(
                    TTextFileCreator.create(),
                    TDirectoryCreator.create(),
                    TContentModifier.create(),
                    fReader,
                    fWriter
                )
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
