(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit DeployTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf;

type

    (*!--------------------------------------
     * Task that:
     * - create apache/nginx virtual host file
     * - enable virtual host config
     * - add entry /etc/hosts
     * - reload web server configuration
     *------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TDeployTask = class(TInterfacedObject, ITask)
    private
        fVirtualHostCreateTask : ITask;
        fEnableVirtualHostTask : ITask;
        fAddDomainToEtcHostTask : ITask;
        fReloadWebServerTask : ITask;
    public
        constructor create(
            aVirtualHostCreateTask : ITask;
            aEnableVirtualHostTask : ITask;
            aAddDomainToEtcHostTask : ITask;
            aReloadWebServerTask : ITask
        );

        destructor destroy(); override;

        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask;
    end;

implementation

uses

    SysUtils;

    constructor TDeployTask.create(
        aVirtualHostCreateTask : ITask;
        aEnableVirtualHostTask : ITask;
        aAddDomainToEtcHostTask : ITask;
        aReloadWebServerTask : ITask
    );
    begin
        fVirtualHostCreateTask := aVirtualHostCreateTask;
        fEnableVirtualHostTask := aEnableVirtualHostTask;
        fAddDomainToEtcHostTask := aAddDomainToEtcHostTask;
        fReloadWebServerTask := aReloadWebServerTask;
    end;

    destructor TDeployTask.destroy();
    begin
        fVirtualHostCreateTask := nil;
        fEnableVirtualHostTask := nil;
        fAddDomainToEtcHostTask := nil;
        fReloadWebServerTask := nil;
        inherited destroy();
    end;

    function TDeployTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        fVirtualHostCreateTask.run(opt, longOpt);
        fEnableVirtualHostTask.run(opt, longOpt);
        fAddDomainToEtcHostTask.run(opt, longOpt);
        fReloadWebServerTask.run(opt, longOpt);
        result := self;
    end;
end.
