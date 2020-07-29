(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit XDeployBalancerTaskFactoryImpl;

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
    TXDeployBalancerTaskFactory = class(TInterfacedObject, ITaskFactory)
    private
        function buildApacheBalancerVhostTask() : ITask;
        function buildNginxBalancerVhostTask() : ITask;
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
    InFanoProjectDirCheckTaskImpl,
    WebServerTaskImpl,
    TextFileCreatorIntf,
    TextFileCreatorImpl,
    DirectoryCreatorImpl,
    ContentModifierImpl,
    FileHelperImpl,
    BaseCreateFileTaskImpl,
    CreateFileConsts,
    VirtualHostIntf,
    VirtualHostWriterIntf,
    WebServerVirtualHostTaskImpl,
    VirtualHostImpl,
    VirtualHostWriterImpl,
    ApacheDebianVHostWriterImpl,
    ApacheFedoraVHostWriterImpl,
    ApacheFreeBsdVHostWriterImpl,
    ApacheVHostBalancerTplImpl,
    NginxLinuxVHostWriterImpl,
    NginxFreeBsdVHostWriterImpl,
    NginxVHostBalancerTplImpl;

    function TXDeployBalancerTaskFactory.buildApacheBalancerVhostTask() : ITask;
    var vhostWriter : IVirtualHostWriter;
        ftext : ITextFileCreator;
        vhost : IVirtualHost;
    begin
        ftext := TTextFileCreator.create();
        vhostWriter := (TVirtualHostWriter.create())
            .addWriter('/etc/apache2', TApacheDebianVHostWriter.create(ftext))
            .addWriter('/etc/httpd', TApacheFedoraVHostWriter.create(ftext))
            .addWriter('/usr/local/etc/apache24', TApacheFreeBsdVHostWriter.create(ftext, 'apache24'))
            .addWriter('/usr/local/etc/apache25', TApacheFreeBsdVHostWriter.create(ftext, 'apache25'));
        vhost := TVirtualHost.create();
        result := TWebServerVirtualHostTask.create(
            vhost,
            TApacheVHostBalancerTpl.create(vhost, getProtocol()),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployBalancerTaskFactory.buildNginxBalancerVhostTask() : ITask;
    var vhostWriter : IVirtualHostWriter;
        ftext : ITextFileCreator;
        vhost : IVirtualHost;
    begin
        ftext := TTextFileCreator.create();
        vhostWriter := (TVirtualHostWriter.create())
            .addWriter('/etc/nginx', TNginxLinuxVHostWriter.create(ftext))
            .addWriter('/usr/local/etc/nginx', TNginxFreeBsdVHostWriter.create(ftext));
        vhost := TVirtualHost.create();
        result := TWebServerVirtualHostTask.create(
            vhost,
            TNginxVHostBalancerTpl.create(
                vhost,
                getProxyPass(),
                getProxyParams(),
                getServerPrefix()
            ),
            vhostWriter,
            TContentModifier.create()
        );
    end;

    function TXDeployBalancerTaskFactory.getServerPrefix() : shortstring;
    begin
        result := '';
    end;

    function TXDeployBalancerTaskFactory.build() : ITask;
    var deployTask : ITask;
        fReader : IFileContentReader;
        fWriter : IFileContentWriter;
    begin
        fReader := TFileHelper.create();
        fWriter := fReader as IFileContentWriter;
        deployTask := TDeployTask.create(
            TWebServerTask.create(
                buildApacheBalancerVhostTask(),
                buildNginxBalancerVhostTask()
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
