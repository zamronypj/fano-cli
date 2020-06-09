(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit CreateCompilerConfigsTaskImpl;

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
    TCreateCompilerConfigsTask = class(TCreateFileTask)
    private
        procedure createCompilerConfigs(const dir : string);
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    sysutils;

    procedure TCreateCompilerConfigsTask.createCompilerConfigs(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/build.cfg.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/build.dev.cfg.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Core/Includes/build.prod.cfg.inc}
    begin
        {$IFDEF FREEBSD}
        createTextFile(
            dir + '/build.cfg',
            StringReplace(strBuildCfg, '-Tlinux', '-Tfreebsd', [rfReplaceAll])
        );
        {$ElSE}
        createTextFile(dir + '/build.cfg', strBuildCfg);
        {$ENDIF}
        createTextFile(dir + '/build.cfg.sample', strBuildCfg);

        createTextFile(dir + '/build.dev.cfg', strBuildCfgDev);
        createTextFile(dir + '/build.dev.cfg.sample', strBuildCfgDev);

        createTextFile(dir + '/build.prod.cfg', strBuildCfgProd);
        createTextFile(dir + '/build.prod.cfg.sample', strBuildCfgProd);
    end;

    function TCreateCompilerConfigsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createCompilerConfigs(baseDirectory);
        result := self;
    end;
end.
