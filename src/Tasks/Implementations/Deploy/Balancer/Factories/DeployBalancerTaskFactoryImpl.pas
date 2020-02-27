(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployBalancerTaskFactoryImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskIntf,
    TaskFactoryIntf;

type

    (*!--------------------------------------
     * Factory class for deploy web application with
     * reverse proxy load balancer
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDeployBalancerTaskFactory = class(TInterfacedObject, ITaskFactory)
    protected
        function getProtocol() : shortstring; virtual; abstract;
        function getProxyPass() : shortstring; virtual; abstract;
        function getProxyParams() : shortstring; virtual; abstract;
        function getServerPrefix() : shortstring; virtual;
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
    ApacheVirtualHostBalancerTaskImpl,
    NginxReloadWebServerTaskImpl,
    NginxVirtualHostBalancerTaskImpl,
    AddDomainToEtcHostTaskImpl,
    RootCheckTaskImpl,
    WebServerTaskImpl,
    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    ContentModifierImpl,
    FileHelperImpl,
    BaseCreateFileTaskImpl;

    function TDeployBalancerTaskFactory.getServerPrefix() : shortstring;
    begin
        result := 'lb-';
    end;

    function TDeployBalancerTaskFactory.build() : ITask;
    var deployTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        deployTask := TDeployTask.create(
            TWebServerTask.create(
                TApacheVirtualHostBalancerTask.create(
                    TTextFileCreator.create(),
                    TDirectoryCreator.create(),
                    TContentModifier.create(),
                    BASE_DIRECTORY,
                    getProtocol()
                ),
                TNginxVirtualHostBalancerTask.create(
                    TTextFileCreator.create(),
                    TDirectoryCreator.create(),
                    TContentModifier.create(),
                    BASE_DIRECTORY,
                    getProtocol(),
                    getProxyPass(),
                    getProxyParams(),
                    getServerPrefix()
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
