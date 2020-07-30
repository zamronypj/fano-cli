(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit XDeployHttpTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf,
    TextFileCreatorIntf,
    DirectoryExistsIntf;

type

    (*!--------------------------------------
     * Factory class for deploy http application
     * using reverse proxy
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TXDeployHttpTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        function buildApacheHttpVhostTask(
            ftext : ITextFileCreator;
            aDirExists : IDirectoryExists
        ) : ITask;
        function buildStdoutApacheHttpVhostTask() : ITask;
        function buildNormalApacheHttpVhostTask() : ITask;
        function buildNginxHttpVhostTask(
            ftext : ITextFileCreator;
            aDirExists : IDirectoryExists
        ) : ITask;
        function buildStdoutNginxHttpVhostTask() : ITask;
        function buildNormalNginxHttpVhostTask() : ITask;
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
    NginxReloadWebServerTaskImpl,
    AddDomainToEtcHostTaskImpl,
    RootCheckTaskImpl,
    InFanoProjectDirCheckTaskImpl,
    WebServerTaskImpl,
    TextFileCreatorImpl,
    StdoutTextFileCreatorImpl,
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
    ApacheVHostHttpTplImpl,
    NginxLinuxVHostWriterImpl,
    NginxFreeBsdVHostWriterImpl,
    NginxVHostHttpTplImpl,
    StdoutCheckTaskImpl,
    DirectoryExistsImpl,
    NullDirectoryExistsImpl;

    function TXDeployHttpTaskFactory.buildApacheHttpVhostTask(
        ftext : ITextFileCreator;
        adirExists : IDirectoryExists
    ) : ITask;
    var vhostWriter : IVirtualHostWriter;
    begin
        vhostWriter := (TVirtualHostWriter.create(aDirExists))
            .addWriter('/etc/apache2', TApacheDebianVHostWriter.create(ftext))
            .addWriter('/etc/httpd', TApacheFedoraVHostWriter.create(ftext))
            .addWriter('/usr/local/etc/apache24', TApacheFreeBsdVHostWriter.create(ftext, 'apache24'))
            .addWriter('/usr/local/etc/apache25', TApacheFreeBsdVHostWriter.create(ftext, 'apache25'));

        result := TWebServerVirtualHostTask.create(
            TVirtualHost.create(),
            TApacheVHostHttpTpl.create(),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployHttpTaskFactory.buildStdoutApacheHttpVhostTask() : ITask;
    begin
        result := buildApacheHttpVhostTask(
            TStdoutTextFileCreator.create(),
            TNullDirectoryExists.create()
        );
    end;

    function TXDeployHttpTaskFactory.buildNormalApacheHttpVhostTask() : ITask;
    begin
        result := buildApacheHttpVhostTask(
            TTextFileCreator.create(),
            TDirectoryExists.create()
        );
    end;

    function TXDeployHttpTaskFactory.buildNginxHttpVhostTask(
        ftext : ITextFileCreator;
        aDirExists : IDirectoryExists
    ) : ITask;
    var vhostWriter : IVirtualHostWriter;
    begin
        vhostWriter := (TVirtualHostWriter.create(aDirExists))
            .addWriter('/etc/nginx', TNginxLinuxVHostWriter.create(ftext))
            .addWriter('/usr/local/etc/nginx', TNginxFreeBsdVHostWriter.create(ftext));

        result := TWebServerVirtualHostTask.create(
            TVirtualHost.create(),
            TNginxVHostHttpTpl.create(),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployHttpTaskFactory.buildStdoutNginxHttpVhostTask() : ITask;
    begin
        result := buildNginxHttpVhostTask(
            TStdoutTextFileCreator.create(),
            TNullDirectoryExists.create()
        );
    end;

    function TXDeployHttpTaskFactory.buildNormalNginxHttpVhostTask() : ITask;
    begin
        result := buildNginxHttpVhostTask(
            TTextFileCreator.create(),
            TDirectoryExists.create()
        );
    end;

    function TXDeployHttpTaskFactory.build() : ITask;
    var normalDeployTask, stdoutDeployTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        normalDeployTask := TDeployTask.create(
            TWebServerTask.create(
                buildNormalApacheHttpVhostTask(),
                buildNormalNginxHttpVhostTask()
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

        //this is just simply output virtual host config to stdout
        //so no need for root privilege and reload web server or
        //messing up /etc/hosts
        stdoutDeployTask := TWebServerTask.create(
            buildStdoutApacheHttpVhostTask(),
            buildStdoutNginxHttpVhostTask()
        );

        result := TStdoutCheckTask.create(
            //if --stdout command line provided, execute this task
            //protect to avoid accidentally running
            //not in FanoCLI generated project directory
            TInFanoProjectDirCheckTask.create(stdoutDeployTask),

            //protect to avoid accidentally running without root privilege
            //and not in FanoCLI generated project directory
            TRootCheckTask.create(TInFanoProjectDirCheckTask.create(normalDeployTask))
        );
    end;

end.
