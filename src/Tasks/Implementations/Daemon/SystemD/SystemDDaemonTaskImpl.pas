(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2022 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit SystemDDaemonTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    BaseCreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that setup application as service with
     * systemd
     *---------------------------------------------
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TSystemDDaemonTask = class(TBaseCreateFileTask)
    private
        procedure createUnitFile(
            const systemDDir :string;
            const svcName : string;
            const appBin : string;
            const username : string
        );
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    SysUtils;

const

    SYSTEMD_DIR = '/etc/systemd/system';

    procedure TSystemDDaemonTask.createUnitFile(
        const systemDDir :string;
        const svcName : string;
        const appBin : string;
        const username : string
    );
    var
        {$INCLUDE src/Tasks/Implementations/Daemon/SystemD/Includes/daemon.service.inc}
    begin
        contentModifier.setVar('[[APP_NAME]]', svcName)
            .setVar('[[APP_BIN]]', appBin)
            .setVar('[[USER]]', userName);
        createTextFile(
            systemDDir + DirectorySeparator + svcName + '.service',
            contentModifier.modify(strDaemonServiceInc)
        );
    end;

    function TSystemDDaemonTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    var svcName : string;
        appBin : string;
        userName : string;
    begin
        inherited run(opt, longOpt);
        result := self;
        svcName := opt.getOptionValue(longOpt);
        if (svcName = '') then
        begin
            writeln('Service name cannot be empty.');
            writeln('Run with --help to view available task.');
            exit();
        end;

        appBin := opt.getOptionValueDef(
            'bin',
            getCurrentDir() + DirectorySeparator + 'bin' +
                DirectorySeparator + 'app.cgi'
        );

        userName := opt.getOptionValueDef(
            'user',
            //we cannot use getEnvironmentVariable('USER')
            //because we will use sudo, so getEnvironmentVariable('USER') will always
            //return root.
            getEnvironmentVariable('SUDO_USER')
        );

        createUnitFile(SYSTEMD_DIR, svcName, appBin, userName);
        result := self;
    end;
end.
