(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployCgiTaskFactoryImpl;

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
    TDeployCgiTaskFactory = class(TInterfacedObject, ITaskFactory)
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
    WebServerTaskImpl,
    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    ContentModifierImpl,
    FileHelperImpl;

    function TDeployCgiTaskFactory.build() : ITask;
    var deployTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        deployTask := TDeployTask.create(
            TWebServerTask.create(
                TApacheVirtualHostCgiTask.create(
                    TTextFileCreator.create(),
                    TDirectoryCreator.create(),
                    TContentModifier.create()
                ),
                //nginx does not support CGI
                TNullTask.create()
            ),
            TWebServerTask.create(
                TApacheEnableVhostTask.create(),
                //TNginxEnableVirtualHostTask.create()
                TNullTask.create()
            ),
            TAddDomainToEtcHostTask.create(fReader, fWriter),
            TWebServerTask.create(
                TApacheReloadWebServerTask.create(),
                //TNginxReloadWebServerTask.create()
                TNullTask.create()
            )
        );

        //protect to avoid accidentally running without root privilege
        result := TRootCheckTask.create(deployTask);
    end;

end.
