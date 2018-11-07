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

    procedure TCreateShellScriptsTask.createShellScripts(const dir : string);
    var
        {$INCLUDE src/Tasks/Implementations/Project/Includes/build.sh.inc}
        {$INCLUDE src/Tasks/Implementations/Project/Includes/build.cmd.inc}
    begin
        createTextFile(dir + '/build.sh', strBuildSh);
        createTextFile(dir + '/build.cmd', strBuildCmd);
    end;


    function TCreateShellScriptsTask.run(
        const opt : ITaskOptions;
        const shortOpt : char;
        const longOpt : string
    ) : ITask;
    var baseDir : string;
    begin
        baseDir := opt.getOptionValue(shortOpt, longOpt);
        createShellScripts(baseDir);
        result := self;
    end;
end.
