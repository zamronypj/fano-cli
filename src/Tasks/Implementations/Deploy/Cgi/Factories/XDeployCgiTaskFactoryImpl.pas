(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit XDeployCgiTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for deploy CGI application
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TXDeployCgiTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        function buildApacheCgiVhostTask() : ITask;
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
    ApacheVirtualHostCgiTaskImpl,
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
    ApacheVHostCgiTplImpl;


    function TXDeployCgiTaskFactory.buildApacheCgiVhostTask() : ITask;
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
            TApacheVHostCgiTpl.create(),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployCgiTaskFactory.build() : ITask;
    var deployTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        deployTask := TDeployTask.create(
            TWebServerTask.create(
                buildApacheCgiVhostTask(),
                //do nothing as nginx does not support CGI
                TNullTask.create()
            ),
            TWebServerTask.create(
                TApacheEnableVhostTask.create(),
                //do nothing as nginx does not support CGI
                TNullTask.create()
            ),
            TAddDomainToEtcHostTask.create(fReader, fWriter),
            TWebServerTask.create(
                TApacheReloadWebServerTask.create(),
                //do nothing as nginx does not support CGI
                TNullTask.create()
            )
        );

        //protect to avoid accidentally running without root privilege
        //and not in FanoCLI generated project directory
        result := TRootCheckTask.create(TInFanoProjectDirCheckTask.create(deployTask));
    end;

end.
