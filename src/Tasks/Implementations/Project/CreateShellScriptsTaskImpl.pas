(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit CreateShellScriptsTaskImpl;

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
     * shell scripts using fano web framework
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    TCreateShellScriptsTask = class(TCreateFileTask)
    private
        procedure createShellScripts(const dir : string);
        procedure createCleanScripts(const dir : string);
        procedure createConfigSetupScripts(const dir : string);
        procedure createSimulateScripts(const dir : string);
    public
        function run(
            const opt : ITaskOptions;
            const longOpt : shortstring
        ) : ITask; override;
    end;

implementation

uses

    {$IFDEF UNIX}
    baseunix, unix,
    {$ENDIF}
    sysutils;

    procedure TCreateShellScriptsTask.createShellScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/build.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/build.cmd.inc}
    begin
        createTextFile(dir + '/build.sh', strBuildSh);
        createTextFile(dir + '/build.cmd', strBuildCmd);
        {$IFDEF UNIX}
        fpChmod(dir + '/build.sh', &775);
        {$ENDIF}
    end;

    procedure TCreateShellScriptsTask.createCleanScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/clear.compiled.units.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/clear.compiled.units.cmd.inc}
    begin
        createTextFile(dir + '/clear.compiled.units.sh', strClearUnitsSh);
        createTextFile(dir + '/clear.compiled.units.cmd', strClearUnitsCmd);
        {$IFDEF UNIX}
        fpChmod(dir + '/clear.compiled.units.sh', &775);
        {$ENDIF}
    end;

    procedure TCreateShellScriptsTask.createConfigSetupScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/config.setup.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/config.setup.cmd.inc}
    begin
        createTextFile(dir + '/config.setup.sh', strConfigSetupSh);
        createTextFile(dir + '/config.setup.cmd', strConfigSetupCmd);
        {$IFDEF UNIX}
        fpChmod(dir + '/config.setup.sh', &775);
        {$ENDIF}
    end;

    procedure TCreateShellScriptsTask.createSimulateScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/simulate.run.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/simulate.run.cmd.inc}
    begin
        createTextFile(dir + '/simulate.run.sh', strSimulateSh);
        createTextFile(dir + '/simulate.run.cmd', strSimulateCmd);
        {$IFDEF UNIX}
        fpChmod(dir + '/simulate.run.sh', &775);
        {$ENDIF}
    end;

    function TCreateShellScriptsTask.run(
        const opt : ITaskOptions;
        const longOpt : shortstring
    ) : ITask;
    begin
        //need to call parent run() so baseDirectory can be initialized
        inherited run(opt, longOpt);
        createShellScripts(baseDirectory);
        createCleanScripts(baseDirectory + '/tools');
        createConfigSetupScripts(baseDirectory + '/tools');
        createSimulateScripts(baseDirectory + '/tools');
        result := self;
    end;
end.