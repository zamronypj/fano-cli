(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateAppConfigsTaskImpl;

interface

{$MODE OBJFPC}
{$H+}

uses

    TaskOptionsIntf,
    TaskIntf,
    CreateFileTaskImpl;

type

    (*!--------------------------------------
     * Task that create web application project
     * compiler config files using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateAppConfigsTask = class(TCreateFileTask)
    private
        procedure createAppConfigs(const dir : string);
    public
        function run(
            const opt : ITaskOptions;
            const shortOpt : char;
            const longOpt : string
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCreateAppConfigsTask.createAppConfigs(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/build.cfg.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/build.dev.cfg.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/build.prod.cfg.inc}
    begin
        createTextFile(dir + '/build.cfg', strBuildCfg);
        createTextFile(dir + '/build.cfg.sample', strBuildCfg);

        createTextFile(dir + '/build.dev.cfg', strBuildCfgDev);
        createTextFile(dir + '/build.dev.cfg.sample', strBuildCfgDev);

        createTextFile(dir + '/build.prod.cfg', strBuildCfgProd);
        createTextFile(dir + '/build.prod.cfg.sample', strBuildCfgProd);
    end;

    function TCreateAppConfigsTask.run(
        const opt : ITaskOptions;
        const shortOpt : char;
        const longOpt : string
    ) : ITask;
    begin
        inherited run(opt, shortOpt, longOpt);
        createAppConfigs(baseDirectory);
        result := self;
    end;
end.
