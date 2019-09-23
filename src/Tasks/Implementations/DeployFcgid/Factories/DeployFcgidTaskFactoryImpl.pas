(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployFcgidTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for deploy FastCGI application
     * with mod_fcgid
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDeployFcgidTaskFactory = class(TInterfacedObject, ITaskFactory)
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
    ApacheVirtualHostFcgidTaskImpl,
    AddDomainToEtcHostTaskImpl,
    RootCheckTaskImpl,
    WebServerTaskImpl,
    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    ContentModifierImpl,
    FileHelperImpl;

    function TDeployFcgidTaskFactory.build() : ITask;
    var deployTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        deployTask := TDeployTask.create(
            TWebServerTask.create(
                TApacheVirtualHostFcgidTask.create(
                    TTextFileCreator.create(),
                    TDirectoryCreator.create(),
                    TContentModifier.create()
                ),
                //nginx does not support something similar like mod_fcgid
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
