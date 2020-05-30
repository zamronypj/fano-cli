(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployUwsgiTaskFactoryImpl;

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
    TDeployUwsgiTaskFactory = class(TInterfacedObject, ITaskFactory)
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
    WebServerTaskImpl,
    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    ContentModifierImpl,
    FileHelperImpl;

    function TDeployUwsgiTaskFactory.build() : ITask;
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
                    TContentModifier.create()
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
        result := TRootCheckTask.create(deployTask);
    end;

end.
